" Vim syntax file
" Language:     twiki
" Maintainer:   Rainer Thierfelder
" Last Change:  2004 Oct 25

" Quit if syntax file is already loaded
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

" info for me : :help usr_44.txt 
" --> infos for writing syntaxfiles

syn match   twikiSeparator   "^---\+"
syn match   twikiListItem   "^\(   \)\+\*\ze "
" \ze in regexpr ends match, but following space must be there
syn match   twikiOrderList  "^\(   \)\+1\ze "
"syn match   twikiWord        "\([\.\-;,<>\*\?]\)\zs\<![A-Z]\w\+[A-Z]\w\+\>"
syn match   twikiWord        "\(\s\|^\)\zs[A-Z][a-z0-9]\+\([A-Z][a-z0-9]\+\)\+\ze\(\>\|_\)"
syn region  twikiLink        start=/\([ ]\)\zs\[\[/ end=/\]\]\ze\([,. ?):-]\|$\)/
" TODO: doesn't work right until now

"syn region  twikiTag	    start="%[^ ]" end="%"
"syn region  twikiTag	    start="<[^ ]" end=">"
syn match   twikiTag	    "%\(\w\)\+%"
syn match   twikiTag	    "<\(\w\)\+>"
" TODO: check, if tags are correct?
" TODO: problems with nested tags

syn region  twikiComment    start="<!--" end="-->"
syn region  twikiVerbatim   start="<verbatim>" end="</verbatim>"

syn region  twikiHead        start=/^---+\+/ end=/$/ oneline

" emphasizing , from twiki-sourcecode:
"# Emphasizing
"            # PTh 25 Sep 2000: More relaxed rules, allow leading '(' and trailing ',.;:!?)'
"            s/([\s\(])==([^\s]+?|[^\s].*?[^\s])==([\s\,\.\;\:\!\?\)])/$1 . &fixedFontText( $2, 1 ) . $3/ge;
"            s/([\s\(])__([^\s]+?|[^\s].*?[^\s])__([\s\,\.\;\:\!\?\)])/$1<strong><em>$2<\/em><\/strong>$3/g;
"            s/([\s\(])\*([^\s]+?|[^\s].*?[^\s])\*([\s\,\.\;\:\!\?\)])/$1<strong>$2<\/strong>$3/g;
"            s/([\s\(])_([^\s]+?|[^\s].*?[^\s])_([\s\,\.\;\:\!\?\)])/$1<em>$2<\/em>$3/g;
"            s/([\s\(])=([^\s]+?|[^\s].*?[^\s])=([\s\,\.\;\:\!\?\)])/$1 . &fixedFontText( $2, 0 ) . $3/ge;
"
syn region  twikiFixed	     start=/\(^\|[ ]\)\zs=/ end=/=\ze\([,. ?):-]\|$\)/
syn region  twikiBoldFixed   start=/\(^\|[ ]\)\zs==/ end=/==\ze\([,. ?):-]\|$\)/
syn region  twikiBold         start=/\(^\|[ ]\)\zs\*/ end=/\*\ze\([,. ?):-]\|$\)/
" TODO: Wie laesst sich kontrollieren, dass noch ein * folgt?
" will man wirklich nen * anzeigen, wird alles folgende als bold
" interpretiert: z.B. 'vor dem *):' soll als einzelner * gewertet werden
syn region  twikiItalic       start=/\(^\|[ ]\)\zs_/ end=/_\ze\([,. ?):-]\|$\)/
syn region  twikiBoldItalic   start=/\(^\|[ ]\)\zs__/ end=/__\ze\([,. ?):-]\|$\)/

" The default highlighting.
if version >= 508 || !exists("did_twiki_syn_inits")
  if version < 508
    let did_twiki_syn_inits = 1
  endif
  
  hi def link twikiHead       Statement
  hi def link twikiLink       Special
  hi def link twikiTag	      Identifier
  hi def link twikiComment    Comment
  hi def link twikiWord       Keyword
  hi def link twikiVerbatim   Type
  hi def     twikiListItem    ctermfg=5
  hi def     twikiOrderList   ctermfg=5
  " TODO: this only works for vim in console, not in GUI
  hi def     twikiFixed	      ctermfg=6
  hi def     twikiBoldFixed   cterm=reverse ctermfg=6
  hi def     twikiItalic      ctermfg=7
  hi def     twikiBoldItalic  cterm=reverse ctermfg=7
  hi def     twikiBold        cterm=reverse
endif

setlocal tabstop=8
setlocal sw=3
setlocal expandtab
setlocal titlestring=TWiki-Edit"
setlocal title
setlocal smarttab
setlocal autoindent

let b:current_syntax = "twiki"

" if one doesn't want this keymappings, set to 0
let SetOwnMaps = 1
if ( SetOwnMaps == 1 )
  " keymapping for twiki:
  imap  <CR><verbatim><CR></verbatim><CR><ESC>kO
elseif SetOwnMaps == 0
  " do nothing
else
  " SetOwnMaps should be 1 or 0 and nothing else!
endif


"EOF vim: tw=78:ft=vim:ts=8
