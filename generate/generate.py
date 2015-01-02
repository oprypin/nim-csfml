# Copyright (C) 2015 Oleh Prypin <blaxpirit@gmail.com>
# 
# This file is part of nim-csfml.
# 
# This software is provided 'as-is', without any express or implied
# warranty. In no event will the authors be held liable for any damages
# arising from the use of this software.
# 
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
# 
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software
#    in a product, an acknowledgement in the product documentation would be
#    appreciated but is not required.
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
# 3. This notice may not be removed or altered from any source distribution.


import sys
import re
import textwrap
import itertools

from pycparser import parse_file, c_ast, c_generator




def rename_sf(name):
    if name is None:
        return name
    if not name.startswith('sf'):
        raise ValueError(name)
    return name[2:]

def rename_type(name):
    orname = name
    m = re.match('^(.+) *\[([0-9]+)\]$', name)
    if m:
        name, arrsize = m.groups()
        arrsize = int(arrsize)
    else:
        arrsize = None
    name = re.sub(r'\bconst\b', '', name).strip()
    if name.startswith('sf') and ('Int' in name or 'Uint' in name) and 'Rect' not in name:
        name = name[2:].lower()
    ptr = name.count('*')
    name = name.replace('*', '').strip()
    name = {
        'int': 'cint',
        'size_t': 'int',
        'unsigned int': 'cint',
        'float': 'cfloat',
        'sfBool': 'IntBool',
        'sfVector2u': 'sfVector2i',
    }.get(name, name)
    if ptr and name=='void':
        ptr -= 1
        name = 'pointer'
    if ptr and 'sf' in name:
        ptr -= 1
        if rename_sf(name) not in classes:
            name = 'var {}'.format(rename_sf(name))
    try:
        name = rename_sf(name)
    except ValueError:
        pass
    name = 'ptr '*ptr+name
    if name=='ptr char':
        name = 'cstring'
    if arrsize:
        name = 'array[{}..{}, {}]'.format(0, arrsize-1, name)
    return name

def rename_identifier(name):
    name = {
        'object': 'obj',
        'type': 'kind',
        'bind': 'bindGL',
    }.get(name, name)
    return name[0].lower()+name[1:]

def common_start(strings):
    if not strings:
        return ''
    first = strings[0]
    for i in range(1, len(first)+1):
        if not all(s[:i]==first[:i] for s in strings):
            return first[:i-1]
    return first



def handle_enum(name, items):
    if name is None:
        yield 'const'
        for name, value in items:
            name = rename_sf(name)
            yield ('  {}* = {}'.format(name, value) if value is not None else name)
        return
    
    nitems = [name for name, value in items]
    c = len(common_start(nitems))
    nitems = [nitem[c:] for nitem in nitems]
    nitems = list(zip(nitems, (value for name, value in items)))

    nname = rename_sf(name)
    if all(value is not None for name, value in nitems):
        nitems.sort(key=lambda kv: int(kv[1]))
    yield 'type {}* {{.pure, size: sizeof(cint).}} = enum'.format(nname)
    yield '\n'.join(textwrap.wrap(', '.join(
        ('{} = {}'.format(name, value) if value is not None else name)
        for name, value in nitems
    ), 80, initial_indent='  ', subsequent_indent='  '))

def handle_struct(name, items):
    if name=='sfVector2u':
        return
    name = rename_type(name)
    yield 'type {}* {{.pure, final.}} = object'.format(name)

    for typ, name in items:
        if typ in ['sfEventType']:
            continue
        yield '  {}*: {}'.format(name, rename_type(typ))


classes = set()
def handle_class(name):
    pname = rename_sf(name)
    classes.add(pname)
    yield 'type\n  {0}* = ptr T{0}\n  T{0} {{.pure, final.}} = object'.format(pname)


def handle_function(main, params):
    ftype, fname = main
    nfname = rename_sf(fname)
    nfname = re.sub(r'(.+)_create.*', r'new\1', nfname)
    nfname = re.sub(r'(.+)_from.+', r'\1', nfname)
    nfname = re.sub(r'(.+)With.+', r'\1', nfname)
    if params:
        p1 = rename_type(params[0][0])+'_'
        if p1.startswith('var '):
            p1 = p1[4:]
        if nfname.startswith(p1):
            nfname = nfname[len(p1):]
    nfname = rename_identifier(nfname)
    nftype = rename_type(ftype)
    main_sgn = 'proc {nfname}*({sparams}): {nftype}'
    main_fn = '{nfname}'
    cimp = ' {{.\n  cdecl, dynlib: lib, importc: "{}".}}'.format(fname)
    if nfname.startswith('get') and nfname[3].isupper() and len(params)==1:
        nfname = nfname[3].lower()+nfname[4:]
    elif nfname.startswith('is') and nfname[2].isupper() and len(params)==1:
        nfname = nfname[2].lower()+nfname[3:]
    elif nfname.startswith('set') and nfname[3].isupper() and len(params)==2:
        main_sgn = 'proc `{nfname}=`*({sparams}): {nftype}'
        main_fn = '`{nfname}=`'
        nfname = nfname[3].lower()+nfname[4:]
    if nftype=='void':
        main_sgn = main_sgn[:-10]
    r = set()
    for repl in itertools.product((True, False), repeat=len(params)):
        aparams = []
        replv = []
        sgn = main_sgn
        for i, (repl, (ptype, pname)) in enumerate(zip(repl, params), 1):
            rtype = rename_type(ptype)
            rname = rename_identifier(pname) or 'p{}'.format(i)
            if ptype.startswith('const') and rtype.startswith('var '):
                if repl:
                    rrtype = rtype[4:]
                    replv.append(rname)
                else:
                    rrtype = '({}){{lvalue}}'.format(rtype)
            else:
                rrtype = rtype
            aparams.append((rname, rrtype))
        sparams = ', '.join('{}: {}'.format(*p) for p in aparams)
        if replv:
            s = sgn.format(**locals())+' ='
            s += '\n  ('+'; '.join('var C{0} = {0}'.format(rname) for rname in replv)
            s += ')\n  '
            s += main_fn.format(**locals())
            s += '('+', '.join('C'+p if p in replv else p for p, _ in aparams)+')'
            r.add(s)
        else:
            r.add(sgn.format(**locals())+cimp)
    yield '\n'.join(sorted(r))


def handle_functiondef(main, params):
    ftype, fname = main
    params = '; '.join(
        '{}: {}'.format(pname or 'p{}'.format(i), rename_type(ptype)) 
        for i, (ptype, pname) in enumerate(params, 1)
    )
    yield 'type {}* = proc({}): {} {{.cdecl.}}'.format(rename_sf(fname), params, rename_type(ftype))


cgen = c_generator.CGenerator()

def type_to_str(node):
    ptrs = 0
    while isinstance(node, c_ast.PtrDecl):
        node = node.type
        ptrs += 1
    return ' '.join(node.type.names)+'*'*ptrs, node.declname

def gen_expr_to_str(node):
    return cgen.visit(node)

def gen_type_to_str(node):
    name = None
    try: name = node.name
    except AttributeError: pass
    try: name = node.declname
    except AttributeError: pass
    typ = gen_expr_to_str(node)
    if name:
        typ = ' '.join(re.sub(r'\b{}\b'.format(name), '', typ).split())
    return typ, name


def _debug(node):
    try:
        for k, v in node.__dict__.items():
            if k.startswith('_'):
                continue
            if isinstance(v, list) and len(v)>0:
                yield '{} = ['.format(k)
                for it in v:
                    yield '    {!r} ('.format(it)
                    for l in _debug(it):
                        yield textwrap.indent(l, '        ')
                    yield ')'
                yield ']'
            else:
                yield '{} = {!r} ('.format(k, v)
                for l in _debug(v):
                    yield textwrap.indent(l, '    ')
                yield ')'
    except Exception as e:
        pass
def debug(node):
    class root:
        pass
    root = root()
    root.root = node
    r = '\n'.join(_debug(root))[7:]
    r = re.sub(r' \(\n *\)', '', r)
    r = re.sub(r' object at 0x[0-9a-f]+', '', r)
    return r

class Visitor(c_ast.NodeVisitor):
    def visit_FuncDecl(self, node):
        try:
            func_type, func_name = type_to_str(node.type)
            func_params = [gen_type_to_str(param_decl) for param_decl in node.args.params] if node.args else []
            if len(func_params)==1 and func_params[0][0]=='void':
                func_params = []
            out(*handle_function((func_type, func_name), func_params))
        except AttributeError as e:
            print(func_name, repr(e), file=sys.stderr)

    def visit_Typedef(self, node):
        if isinstance(node.type.type, (c_ast.Enum, c_ast.Struct)):
            node.type.type.my_name = node.type.declname
        if type(node.type.type).__name__=='Union':
            out('include csfml_union_{}'.format(rename_sf(node.type.declname).lower()))
        try:
            r = (
                (gen_type_to_str(node.type.type.type.type)[0], node.name),
                [gen_type_to_str(p) for p in node.type.type.args.params]
            )
        except Exception as e:
            pass
        else:
            out(*handle_functiondef(*r))
            return

        self.generic_visit(node)

    def visit_Enum(self, node):
        try:
            name = node.my_name
        except AttributeError:
            name = node.name
        if node.values:
            items = [
                (en.name, (gen_expr_to_str(en.value) if en.value else None))
                for en in node.values.enumerators
            ]
            out(*handle_enum(name, items))
        else:
            global cmodule
            cmodule = name.split('_')[1].lower()
            out('\n#--- {} ---#'.format(name.replace('_', '/')))

        self.generic_visit(node)

    def visit_Struct(self, node):
        try:
            name = node.my_name
        except AttributeError:
            name = node.name
        if node.decls:
            items = [gen_type_to_str(decl) for decl in node.decls]
            out(*handle_struct(name, items))
        else:
            out(*handle_class(name))

        self.generic_visit(node)



files = {}
def out(*args):
    if not args:
        return
    try:
        f = files[cmodule]
    except KeyError:
        files[cmodule] = f = open('csfml_{}_gen.nim'.format(cmodule), 'w')
    else:
        if not args[0].startswith(' '):
            print(file=f)
    for arg in args:
        print(arg, file=f)


filename, = sys.argv[1:]
ast = parse_file(filename)
Visitor().visit(ast)