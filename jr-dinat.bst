%% JR-DINAT.BST   Version 1.0   2004-08-28 
%% (c) Johannes Ruthenberg   email:johannes@bolarus.de
%%
%% Patched to accomodate some of my preferences:
%%   - no space between address and :
%%   - author/editor last names not in smallcaps
%%   - no space between names and ;
%%   - introduced type INTERNET
%%   - no (Veranst.) behind the organization name for INTERNET and MANUAL
%%   - put url date before url
%%   - made labels in bibliography bold face the hardwired way because the 
%%     natbib.cfg file wasn't working
%%   - made the output mechanisms a bit easier and more reliable 
%%   - extensively added comments throughout the whole file
%%
%% Beware: Not all of the comments might be right or make sense!
%%------------------------------------------------------------------------------
%% DINAT.BST   Version 2.5   2000-11-14 
%% (c) Helge Baumann   email:Helge.Baumann@gmx.de
%%------------------------------------------------------------------------------
%% For use with BibTeX version 0.99a or later.
%%------------------------------------------------------------------------------
%% Copying of this file is authorized only if either
%% (1) you make absolutely no changes to your copy, including name, or
%% (2) if you do make changes, you name it something other than dinat.bst, 
%% natdin.bst, plain.bst, unsrt.bst, alpha.bst, and abbrv.bst.
%% This restriction helps ensure that all standard styles are identical.
%%------------------------------------------------------------------------------
%% This is a full author-year citation style bibliography. As such, it is
%% non-standard LaTeX, and requires the natbib-package by Patrick W. Daly,
%% version 7 or higher to function properly.
%% It should be used with the following configuration in natbib.cfg:
%% \newcommand{\bibstyle@dinat}%
%%     {\bibpunct{(}{)}{;}{a}{}{,~}%
%%      \gdef\NAT@biblabelnum##1{\textbf{##1}}}
%%------------------------------------------------------------------------------
%% The form of the \bibitem entries is
%%   \bibitem[Jones u. a.(1990)Jones, Baker und Smith]{key}...
%% If there are more [Jones u. a. 1990], a single character is added to 
%% the year like in [Jones u.a.(1990{\natexlab{a}})Jones, Baker und Smith].
%% The resulting bibliography entry is
%%   \textsc{Jones}, \textsc{Baker} und \textsc{Smith} ...
%% The \cite command functions as follows:
%%   \cite{key}                ==>>  Jones u. a. (1990)
%%   \cite[chap. 2]{key}       ==>>  (Jones u. a. 1990, chap. 2)
%%   \cite[e.g.][]{key}        ==>>  (e.g. Jones u. a. 1990)
%%   \cite[e.g.][p. 32]{key}   ==>>  (e.g. Jones u. a. p. 32)
%%   \citep{key}               ==>>  (Jones u. a. 1990)
%%   \citep*{key}              ==>>  (Jones, Baker und Smith 1990)
%%   \citet{key}               ==>>  Jones u. a. (1990)
%%   \citet*{key}              ==>>  Jones, Baker und Smith (1990)
%%   \citeauthor{key}          ==>>  Jones u. a.
%%   \citeauthor*{key}         ==>>  Jones, Baker und Smith
%%   \citeyear{key}            ==>>  1990
%%------------------------------------------------------------------------------
%% This bibliography style file is intended for texts in german.
%% It draws up bibliographies in accordance with the german DIN 1505, 
%% part 2 and 3, as discribed in the german text
%% http://www.fh-hamburg.de/pers/Lorenzen/tum/litverz.ps
%%------------------------------------------------------------------------------
%% This style is based on the natdin.bst style.
%% The intention for designing a new style for the same result 
%% were the many bugs and the poor design of the original style.
%% So i simplified the programming and add some comments for rework.
%% The names of the functions were changed to reflect their functionality:
%%   out.*:    write the top of the stack to the bbl-file
%%   format.*: format the top of the stack
%%   push.*:   put one item on top of the stack
%%------------------------------------------------------------------------------
%% There are some non standard fields for most entries:
%%   isbn: international book number
%%   issn: internation journal number
%%   url: for electronic published documents or additional information
%%        if there is no publisher and address, the url is used instead,
%%        else it acts like a additional note
%%   urldate: the date of the access to the url
%%------------------------------------------------------------------------------
%% Author(s):
%%   HB: Helge Baumann, helge.baumann@gmx.de
%%------------------------------------------------------------------------------
%% History:
%%   (only main changes are listed, for others see the webpage)
%%   2000-04-10 (HB): Initial release
%%   2000-04-18 (HB): Version 1.1:
%%                      corrected some typos and oversights
%%                      minor changes in output
%%   2000-04-25 (HB): Version 1.2:
%%                      dinat only: added \natexlab
%%                      using full key/cite for label
%%   2000-05-02 (HB): Version 2.0:
%%                      added urldate for date of visit
%%                      added labels in bibliography, so the seperate 
%%                        style dinnat.bst is not needed anymore
%%   2000-05-09 (HB): Version 2.1:
%%                      removed blanc in bibpunct
%%                      put text ("u.\,a." ...) in functions
%%                      rebuild some push functions
%%                      changed \cite to \citep
%%                      removed push.crossref.editor (not used)
%%   2000-07-12 (HB): version 2.2:
%%                      added push.crossref
%%                      changed many crossrefs
%%                      corrected typos
%%                      put \, in curly braces
%%   2000-10-03 (HB): version 2.3:
%%                      changed remaining "u.~a."
%%                      added \labelsep behind dinatlabel
%%                      added mastersthesis again, keeping (wrong) 
%%                        masterthesis (sorry for that)
%%                      minor changes in proceedings
%%   2000-11-05 (HB): version 2.4:
%%                      improved inbook
%%                      removed extra period from proceedings
%%                      added missing colon in misc
%%                      improved name formatting
%%                      removed long dashes from ISBN/ISSN
%%                      restructured format.dashes
%%   2000-11-14 (HB): version 2.5:
%%                      always use key for label if present
%%------------------------------------------------------------------------------


%%------------------------------------------------------------------------------
%% push standard text items on top of the stack
%%------------------------------------------------------------------------------

FUNCTION {push.bd}        { "Bd." }
FUNCTION {push.diplom}    { "Diplomarbeit" }
FUNCTION {push.disser}    { "Dissertation" }
FUNCTION {push.forschung} { "Forschungsbericht" }
FUNCTION {push.hrsg}      { "Hrsg." }
FUNCTION {push.in}        { "In:" }
FUNCTION {push.isbn}      { "ISBN" }
FUNCTION {push.issn}      { "ISSN" }
FUNCTION {push.kap}       { "Kap." }
FUNCTION {push.nr}        { "Nr." }
FUNCTION {push.sn}        { "S" }
FUNCTION {push.s}         { "S." }
FUNCTION {push.siehe}     { "Siehe" }
FUNCTION {push.ua}        { "u.\,a." }
FUNCTION {push.und}       { "und" }
FUNCTION {push.url.name}  { "URL" }
FUNCTION {push.veranst}   { "Veranst." }
FUNCTION {push.von}       { "von" }
FUNCTION {push.zugriff}   { "Zugriffsdatum" }
FUNCTION {push.cite}      { "\citep" }


%%------------------------------------------------------------------------------
%% Definitions for every bibliography entry
%%------------------------------------------------------------------------------

ENTRY
  % fields (crossref is default)
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    isbn
    issn
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    url
    urldate
    volume
    year
  }

  % INTEGERS
  {}

  % STRINGS (sort.key$ is default)
  { label extra.label sort.label short.list dinat.label }
  
  STRINGS { h s t u v } 


%%------------------------------------------------------------------------------
%% required macros for abbr. names of month
%%------------------------------------------------------------------------------
MACRO {jan} {"Januar"}

MACRO {feb} {"Februar"}

MACRO {mar} {"M\^^b{a}rz"}

MACRO {apr} {"April"}

MACRO {may} {"Mai"}

MACRO {jun} {"Juni"}

MACRO {jul} {"Juli"}

MACRO {aug} {"August"}

MACRO {sep} {"September"}

MACRO {oct} {"Oktober"}

MACRO {nov} {"November"}

MACRO {dec} {"Dezember"}


%%------------------------------------------------------------------------------
%% macros for common journals
%%------------------------------------------------------------------------------
MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}


%%------------------------------------------------------------------------------
%% for debugging (not used)
%%------------------------------------------------------------------------------
FUNCTION {show}
% show quoted top of stack
{ duplicate$ "::::  `" swap$ * "'" * top$
}

FUNCTION {show.stack}
% show and clear whole stack
{ "STACK====================================================================="
  top$
  stack$
  "ENDSTACK=================================================================="
  top$
}


%%------------------------------------------------------------------------------
%% logical functions
%%------------------------------------------------------------------------------
FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   { skip$ }
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    { skip$ }
  if$
}


%%------------------------------------------------------------------------------
%% format entries for full author/editor citations
%%------------------------------------------------------------------------------

INTEGERS { nameptr namesleft pos len } 

FUNCTION {format.full.names}
% format top item of stack: assuming it's one or more names
{ 's :=                         %% assign top item of stack to variable s
  ""                            %% push empty String on stack
  #1 'nameptr :=                %% assign #1 to variable nameptr
  s num.names$ 'namesleft :=    %% assign num.names$ to variable namesleft
  { namesleft #0 > } % while
    { s nameptr "{vv~}{ll}" format.name$ 't :=
      nameptr #1 =
        %% first name
        { t * }                 %% add name to top of stack
        { namesleft #1 =
            %% last name
            { t "others" =
                { " " *         %% add to top of stack
                  push.ua *     %% add 'u.a.' String to top of stack
                }  
                { " " *         %% add space to top of stack
                  push.und *    %% add 'und' String to top of stack
                  " " *         %% add space to top of stack
                  t *           %% add name to top of stack
                }
              if$
            }
            %% other names
            { ", " *            %% add separator to top of stack
              t *               %% add name to top of stack
	          } 
          if$
        }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$ % { namesleft #0 > }
}
			
			
FUNCTION {key.full}
{ key empty$
    { cite$ }
    { key }                     %% push key on stack
  if$
}
			
			
FUNCTION {author.key.full}
{ author empty$
    { key.full }                %% push key on stack
    { author                    %% push author on stack
      format.full.names         %% format author names
    }
  if$
}


FUNCTION {editor.key.full}
{ editor empty$
    { key.full }                %% push key on stack
    { editor                    %% push editor on stack
      format.full.names         %% format editor names
    }
  if$
}


FUNCTION {author.editor.key.full}
{ author empty$
    { editor.key.full }         %% push editor or key on stack
    { author                    %% push author on stack
      format.full.names         %% format author names
    }
  if$
}
			
			
FUNCTION {make.full.names}
{ type$ "book" =
  type$ "inbook" =
  or                            %% if (type == book) || (type == inbook)
    { author.editor.key.full }  %% push author, editor or key on stack
    { type$ "proceedings" =     %% if type == proceedings
        { editor.key.full }     %% push editor or key on stack
        { author.key.full }     %% push author or key on stack
      if$
    }
  if$
}


%%------------------------------------------------------------------------------
%% output lines to .bbl file
%%------------------------------------------------------------------------------

FUNCTION {out.block.colon}
% takes what's on the stack, appends a ": " and writes it to the .bbl file
{ ": " *                        %% add to top of stack
  write$                        %% pop from stack and write to file
  newline$                      %% write newline in file
  "\newblock "                  %% push on stack
  write$                        %% pop from stack and write to file
}


FUNCTION {out.block.period}
% takes what's on the stack, appends a ". " and writes it to the .bbl file
{ ". " *                        %% add to top of stack
  write$                        %% pop from stack and write to file
  newline$                      %% write newline in file
  "\newblock "                  %% push on stack
  write$                        %% pop from stack and write to file
}


FUNCTION {out.block.space}
% takes what's on the stack, appends only " " and writes it to the .bbl file
{ " " *                         %% add to top of stack
  write$                        %% pop from stack and write to file
  newline$                      %% write newline in file
  "\newblock "                  %% push on stack
  write$                        %% pop from stack and write to file
}


%%------------------------------------------------------------------------------
%% check before output
%%------------------------------------------------------------------------------
			
FUNCTION {out.colon.check} 
% output only if top item of stack is not empty or empty String
{ duplicate$ empty$ 
    { pop$ }                    %% pop empty item or empty String from stack
    { out.block.colon }
  if$
}			


FUNCTION {out.period.check}
% output only if top item of stack is not empty or empty String
{ duplicate$ empty$ 
    { pop$ }                    %% pop empty item or empty String from stack
    { out.block.period }
  if$
}			


FUNCTION {out.space.check} 
% output only if top item of stack is not empty or empty String
{ duplicate$ empty$ 
    { pop$ }                    %% pop empty item or empty String from stack
    { out.block.space }
  if$
}			


FUNCTION {out.colon.check.required}
% output only if top item of stack is not empty or empty String, else drop a
% warning about missing required value
{ 't :=                         %% assign top of stack to variable t
  duplicate$ empty$ 
    { pop$                      %% pop empty item from stack
      "empty " t * " in " * cite$ * warning$ 
                                %% warning about missing required value
    }
    { out.block.colon }         %% call out method
  if$
}


FUNCTION {out.period.check.required}
% output only if top item of stack is not empty or empty String, else drop a
% warning about missing required value
{ 't :=                         %% assign top of stack to variable t
  duplicate$ empty$ 
    { pop$                      %% pop empty item from stack
      "empty " t * " in " * cite$ * warning$ 
                                %% warning about missing required value
    }
    { out.block.period }        %% call out method
  if$
}


FUNCTION {out.space.check.required}
% output only if top item of stack is not empty or empty String, else drop a
% warning about missing required value
{ 't :=                         %% assign top of stack to variable t
  duplicate$ empty$ 
    { pop$                      %% pop empty item from stack
      "empty " t * " in " * cite$ * warning$ 
                                %% warning about missing required value
    }
    { out.block.space }         %% call out method
  if$
}


%%------------------------------------------------------------------------------
%% write bibentry to .bbl file
%%------------------------------------------------------------------------------

FUNCTION {out.bibitem.start}
% writes the start of a bibitem entry to the .bbl file, like:
%     \bibitem[Lohr:01(2003)Lohr und Deppe]{Lohr:01}
%     \dinatlabel{\textbf{Lohr:01}}
{ newline$                      %% write newline in file
  "\bibitem["                   %% push on stack
  label *                       %% add to top of stack
  make.full.names               %% push on top of stack
  duplicate$ short.list =       %% short.list => part of label, normally the key
    { pop$ }                    %% pop current item from stack, it is the same
                                %% as the label
    { * }                       %% join two top items on stack, label and names
  if$
  "]{" * cite$ * "}" *          %% add to top of stack
  write$                        %% pop from stack and write to file
  newline$                      %% write newline in file
  "\dinatlabel{\textbf{"        %% push on stack
  dinat.label * "}} " *         %% add to top of stack
  write$                        %% pop from stack and write to file
}


FUNCTION {out.bibitem.end}
% writes the end of a bibitem entry to the .bbl file
{ newline$                      %% write newline in file
}


%%------------------------------------------------------------------------------
%% manipulate entries on the stack
%%------------------------------------------------------------------------------

FUNCTION {tilde.or.space.connect}
% connect top two items with space or ~, if second is shorter than 3 characters
{ duplicate$ text.length$ #3 <  %% look at length of top item
    { "~" }                     %% push '~' on stack
    { " " }                     %% push ' ' on stack
  if$
  swap$ *                       %% swap 2nd item and String, join them '~item2'
  *                             %% join 1st and 2nd item 'item1~item2'
}


%%------------------------------------------------------------------------------
%% format text
%%------------------------------------------------------------------------------

FUNCTION {format.emphasize}
% formats top item of stack emphasized or replaces empty item with empty String
{ duplicate$ empty$
    { pop$                      %% pop empty item from stack
      ""                        %% push empty string on stack
    }
    { "\emph{"                  %% push on stack
      swap$ *                   %% swap top two stack items and join them
      "}" *                     %% add to top of stack
    }
  if$
}


FUNCTION {format.smallcaps}
% formats top item of stack smallcapsed or replaces empty item with empty String
{ duplicate$ empty$
    { pop$                      %% pop empty item from stack
      ""                        %% push empty string on stack
    }
    { "\textsc{"                %% push on stack
      swap$ *                   %% swap top two stack items and join them
      "}" *                     %% add to top of stack
    }
  if$
}


FUNCTION {format.dashes}
% format top item of stack: replace single dashes (-) with tex-style dashes (--)
{ 't :=                         %% won't comment in detail, but seems to work ok
  ""
  { t empty$ not } % while$
	    { t #1 #2 substring$ "--" =
	        { { t #1 #1 substring$ "-" = }
	            { "-" *
	              t #2 global.max$ substring$ 't :=
	            }
	          while$
	        }
	        { t #1 #1 substring$ "-" =
	            { "--" * }
	            { t #1 #1 substring$ * }
	          if$
	          t #2 global.max$ substring$ 't :=
	        }
	      if$
	    }
  while$ % { t empty$ not }
}


%%------------------------------------------------------------------------------
%% format names on stack
%%------------------------------------------------------------------------------

STRINGS { hrsg }

FUNCTION {format.names}
% format top item of stack: assuming it's one or more names
{ 's :=                         %% assign top item of stack to variable s
  ""                            %% push empty String on stack
  #1 'nameptr :=                %% assign #1 (?!) to variable nameptr
  s num.names$ 'namesleft :=    %% assign num.names$ to variable namesleft
  { namesleft #0 > }            %% begin while names left
     { %% start last names
       s nameptr "{ll}"         %% push stuff for last names on stack
       format.name$             %% format last names
       't :=                    %% assign last names to variable t
                                %% previously here: t format.smallcaps 't :=
       %% start first names
       s nameptr "{, ff}"       %% push stuff for first names on stack
       format.name$             %% format first names
       'u :=                    %% assign first names to variable u
       u text.length$ 'len :=   %% assign first names' length to variable len
       #1 'pos :=               %% assign #1 (?!) to variable pos
       "" 'v :=                 %% assign empty String to variable v
       { pos len < }            %% while pos < len
          { u pos #1 substring$ "~" = 
              { v "" =
                  { u #1 pos #1 - substring$ 
                    'v :=       %% assign top of stack to variable v
                  }
                  { skip$ }
                if$
		            %% cut second and more first names
                v u pos #2      %% push on stack
                substring$ *    %% add to top of stack
                "." *           %% add to top of stack
                'v :=           %% assign top of stack to variable v
              }
              { skip$ }
            if$
            pos #1 + 'pos :=    %% assign sum of pos and #1 to variable pos
          }
       while$                   %% end while pos < len
       v "" =                   %% if v == ""
         { u 'v := }            %% assign u to variable v
	       { skip$ }             
       if$
       %% all name parts like 'von', 'de' etc.
       s nameptr "{ vv}"        %% push stuff for 'von' on stack
       format.name$             %% format 'von'
       'u :=                    %% assign 'von' to variable u
       %% put it all together
       t                        %% push last names on stack
       v *                      %% add first names to top of stack
       u *                      %% add 'von' to top of stack
       hrsg *                   %% add variable hrsg to top of stack (empty if 
                                %% no editor)
       't :=                    %% assign the whole name to variable t
       nameptr #1 =
         { t * }                %% add the first name to top of stack
         { namesleft #1 =
             { t "others" format.smallcaps = 
               t "others" format.smallcaps hrsg * = 
               or
                 { " " *        %% add to top of stack
                   push.ua *    %% add String 'u.a.' to top of stack
                 }
                 { "; " *       %% add to top of stack
                   t *          %% add another name to top of stack
                 }
               if$
             }
             { "; " *           %% add to top of stack
               t *              %% add another name to top of stack
	           }
           if$                  %% end if namesleft #1 =
         }
       if$                      %% end if nameptr #1 =
       nameptr #1 + 'nameptr :=
       namesleft #1 - 'namesleft :=
    }
  while$ % { namesleft #0 > }
  "" 'hrsg :=                   %% set variable hrsg back to empty String
}


%%------------------------------------------------------------------------------
%% push formatted or empty field(s) on top of the stack
%%------------------------------------------------------------------------------

FUNCTION {push.authors}
% push on stack: empty String, if author name is null, or formatted author names
{ author empty$
    { "" }                      %% push on stack
    { author                    %% push on stack
      format.names              %% format top item of stack
    }
  if$
}

			
FUNCTION {push.editors}
% push on stack: empty String, if editor name is null, or formatted editor names
{ editor empty$
    { "" }                      %% push on stack
    { " ("                      %% push on stack
      push.hrsg *               %% add to top of stack
      ")" *                     %% add to top of stack
      'hrsg :=                  %% save into hrsg variable, used in format.names
      editor                    %% push on stack
      format.names              %% format top item of stack
    }
  if$
} 
			
			
FUNCTION {push.authors.editors}
% push on stack: empty String, if both editor and author names are null, or 
% formatted editor names, if author name is null, or formatted author and editor
% names
{ author empty$
    { push.editors }            %% push editors on stack, empty String if null
    { push.authors              %% push authors on stack, empty String if null
      editor empty$
        { skip$ }
        { "; " *                %% add separator to top of stack
          push.editors *        %% add editors to top of stack
        }
      if$
    }
  if$
}
			
			
FUNCTION {push.organization}
% push on stack: empty String, if organization is null, or organization name 
% with an appended (Veranst.)
{ organization empty$
    { "" }                      %% push on stack
    { organization              %% push on stack
      " (" *                    %% add to top of stack
      push.veranst *            %% add to top of stack
      ")" *                     %% add to top of stack
    }
  if$
}
			
			
FUNCTION {push.organization.noorg}
% push on stack: empty String, if organization is null, or organization name but
% without the appended (Veranst.)
{ organization empty$
    { "" }                      %% push on stack
    { organization }            %% push on stack
  if$
}
			
			
FUNCTION {push.title}
% push on stack: empty String, if title is null, or title
{ title empty$
    { "" }                      %% push on stack
    { title }                   %% push on stack
  if$
}
			

FUNCTION {push.date}
% push on stack: empty String, if both month and year are null, or one of both, 
% if the other is null, or both month and year, separated by a space
{ year empty$
    { month empty$
        { "" }                  %% push on stack
        { "there's a month but no year in " cite$ * warning$
                                %% warning about missing year
          month                 %% push on stack
        }
      if$
    }
    { month empty$
        { year }                %% push on stack
        { month                 %% push on stack
          " " *                 %% add separating space to top of stack
          year *                %% add year to top of stack
        }
      if$
    }
  if$
}			


FUNCTION {push.url}
% push on stack: empty String, if URL is null, or the URL, either with or without
% a prefixed date of view, both separated by a comma
{ url empty$
    { "" }                      %% push on stack
    { urldate empty$
        { "" }                  %% push on stack
        { push.zugriff          %% push on stack
	        ": " *                %% add to top of stack
	        urldate *             %% add to top of stack
	        ", " *                %% add to top of stack
	      }
      if$
      push.url.name *           %% add 'URL' String to top of stack
	    ": " *                    %% add to top of stack
      " \url{" *                %% add to top of stack
      url *                     %% add to top of stack
      "}" *                     %% add to top of stack
    }
  if$
}
			
			
FUNCTION {push.address.publisher.year}
% push on stack: either
% - if address, publisher, URL and year are null: empty String
% - if address, publisher and URL are null: the year
% - if address and publisher are null: the year, if it is not null, and the URL
% - if address is null: the publisher and the year, if it is not null
% - else: address, and publisher and year, if they are not null
{ address empty$
    { publisher empty$
        { url empty$
            { year empty$ 
                { "no publisher, address, url or date in " cite$ * warning$
                                %% warning about missing imprint
                  ""            %% push empty String on stack
                }
                { push.date }   %% push date on stack
              if$
            }
            { "no proper publisher, using url in " cite$ * warning$
                                %% warning about missing publisher
              year empty$
                { "" }          %% push empty String on stack
                { push.date     %% push URL on stack
                  ", " *        %% add to top of stack
                }
              if$
              push.url *        %% add to top of stack
            }
          if$
        }
        { publisher             %% push publisher on stack
	        year empty$
            { "there's a publisher but no year in " cite$ * warning$ }
                                %% warning about missing year
            { ", " *            %% add to top of stack
              push.date *       %% add to top of stack
            }
          if$
        }
      if$
    }
    { address                   %% push address on stack
      publisher empty$
        { "there's an address but no publisher in " cite$ * warning$ }
                                %% warning about missing publisher
        { ": " *                %% add to top of stack
          publisher *           %% add to top of stack
        }
      if$
      year empty$
    	  { skip$ }
        { ", " *                %% add to top of stack
          push.date *           %% add to top of stack
        }
      if$
    }
  if$
}
			
			
FUNCTION {push.title.formatted}
% push on stack: empty String, if title is null, or formatted title
{ title empty$
    { "" }                      %% push empty String on stack
    { title                     %% push title on stack
      format.emphasize          %% format title with emphasize tag
    }
  if$
}
			

FUNCTION {push.title.series.volume}
% push on stack: either
% - if number, series and volume are null: empty String, if title is null, or 
%   formatted title
% - if number and series are null: formatted title, if it is not null, and 
%   volume
% - if number is null and volume is not: series, volume, and formatted title
% - else: formatted title
{ number empty$
    { series empty$
        { push.title.formatted  %% push formatted title on stack
	        volume empty$
            { skip$ }
            { "" =              %% is title empty String?
                { skip$ }
                { ". " * }      %% add to top of stack
              if$
              push.bd *         %% add to top of stack
              volume            %% push on stack
              tilde.or.space.connect
                                %% connect top two items with space or ~, if 
                                %% second is shorter than 3 characters
            }
          if$
        }
        { volume empty$
            { push.title.formatted }
                                %% push formatted title on stack
            { series            %% push series on stack
              format.emphasize  %% format it emphasized
              ". " *            %% add to top of stack
      	      push.bd *         %% add to top of stack
      	      volume            %% push volume on stack
      	      tilde.or.space.connect 
      	                        %% connect top two stack items with space or ~ 
	            ": " *            %% add to top of stack
	            push.title.formatted *  
	                              %% add formatted title to top of stack
	          } 
          if$
        }
      if$
    }
    { push.title.formatted }    %% push formatted title on stack
  if$
}
			

FUNCTION {push.article.in.journal}
% push on stack: either
% - if journal is null: empty String
% - if there's an author and title: formatted journal name
% - else: 'In: ' and formatted journal name
{ journal empty$
    { "" }                      %% push empty String on stack
    { author missing$
      title missing$
      and
        { journal               %% push journal name on stack
          format.emphasize      %% format journal name as emphasized
        }
        { push.in               %% push 'In' String on stack
          " " *                 %% add to top of stack
          journal               %% push journal name on stack
          format.emphasize      %% format journal name as emphasized
          *                     %% join 'In ' and journal name
        }
      if$
    }
  if$
}
			
			
FUNCTION {push.series.number}
% push on stack: either
% - if volume, series and number are null: empty String
% - if volume and series are null: number in parentheses
% - if volume is null: series and number, if it is not null, in parentheses
% - if series is null: empty String
% - else: series and number if the type is proceedings, else empty String
{ volume empty$
    { series empty$
        { number empty$
            { "" }              %% push empty String on stack
            { "there's a number but no series in " cite$ * warning$ 
                                %% warning about missing series
              "("               %% push on stack
              number *          %% add to top of stack
              ")" *             %% add to top of stack
	          }
	        if$
	      }
        { "("                   %% push on stack
				  series *              %% add series to top of stack
				  number empty$
				    { skip$ }
				    { number            %% push number on stack
				      tilde.or.space.connect
				                        %% connect top two stack items with space or ~
				    }
				  if$
          ")" *                 %% add to top of stack
				}
      if$
    }
    { series empty$
        { "" }                  %% push empty String on stack
        { type$ "proceedings" =
            { "("               %% push on stack
              series *          %% add series to top of stack
	            number empty$ 
                { skip$ }
                { number        %% push number on stack
                  tilde.or.space.connect
                                %% connect top two stack items with space or ~
                }
              if$ 
              ")" *             %% add to top of stack
            }
            { "" }              %% push empty String on stack
          if$
        }
      if$
    }
  if$
}
			
			
FUNCTION {push.series.parenth}
% push on stack: empty String, if series is null, or series in parentheses
{ series empty$
    { "" }                      %% push empty String on stack
    { "("                       %% push on stack
      series *                  %% add series to top of stack
      ")" *                     %% add to top of stack
    }
  if$
}
			
			
FUNCTION {push.edition}
% push on stack: empty String, if edition is null, or edition
{ edition empty$
    { "" }                      %% push empty String on stack
    { edition }                 %% push edition on stack
  if$
}
			
			
FUNCTION {push.isbn.issn}
% push on stack: empty String, if both ISSN and ISBN are null, or ISSN, if ISBN 
% is null, or ISBN
{ isbn empty$
    { issn empty$
        { "" }                  %% push empty String on stack
        { push.issn             %% push ISSN name on stack
          " " *                 %% add to top of stack
          issn *                %% add to top of stack
        }
      if$
    }
    { push.isbn                 %% push ISBN name on stack
      " " *                     %% add to top of stack
      isbn *                    %% add to top of stack
    }
  if$
}
			
			
FUNCTION {push.pages.count}
% push on stack: empty String, if pages is null, or pages formatted as page 
% count of a work
{ pages empty$
    { "" }                      %% push empty String on stack
    { pages                     %% push pages on stack
      format.dashes             %% format dashes in pages
      "~" *                     %% add to top of stack
      push.sn *                 %% add 'S' String to top of stack
    }
  if$
}
			
			
FUNCTION {push.pages.range}
% push on stack: empty String, if pages is null, or pages formatted as page 
% range, e.g. of an article within a journal
{ pages empty$
    { "" }
    { push.s *                  %% add 'S. ' String to top of stack
      "~" *                     %% add to top of stack
      pages                     %% push pages on stack
      format.dashes             %% format dashes in pages
      *                         %% join the top two items on stack
    }
  if$
}
			
			
FUNCTION {push.vol.year.num.pages}
% push on stack: either
% - if year, month, number and pages are null: empty String
% - else (whatever is not null):
%   volume, or volume and year, in parentheses AND/OR
%   the month, separated by comma AND/OR
%   the number, separated by comma AND/OR
%   page count, if title is null, or page rank
{ year empty$
    { "there's no year in " cite$ * warning$ }
                                %% warning about missing year
    { "("                       %% push on stack 
      volume empty$
        { "there's no volume in " cite$ * warning$ }
                                %% warning about missing volume
        { volume *              %% add volume to top of stack
          "/" *                 %% add to top of stack
        }
      if$
      year *                    %% add year to top of stack
      ")" *                     %% add to top of stack
    }
  if$
  month empty$
    { skip$ }
    { duplicate$ empty$
        { pop$                  %% pop empty item from stack    
          month                 %% push month on stack
        }
        { ", " *                %% add to top of stack
          month *               %% add month to top of stack
        }
      if$
    }
  if$
  number empty$
    { skip$ }
    { duplicate$ empty$
        { pop$                  %% pop empty item from stack    
          ""                    %% push empty String on stack
        }
        { ", " * }              %% add to top of stack
      if$
      push.nr *                 %% add 'Nr.' String to top of stack
      "~" *                     %% add to top of stack
      number *                  %% add number to top of stack
    }
  if$
  pages empty$
    { skip$ }
    { duplicate$ empty$
        { skip$ }
        { ", " *                %% add to top of stack
	        title missing$
            { push.pages.count * }
                                %% add page number of journal to top of stack
            { push.pages.range * }
                                %% add page range of article to top of stack
          if$ 
        }
      if$
    }
  if$
  duplicate$ empty$
    { pop$                  %% pop empty item from stack    
      ""                    %% push empty String on stack
    }
    { skip$ }
  if$
}
			
			
%			FUNCTION {push.chapter.pages}
%			% chapter and pages
%			{ chapter empty$
%			    { push.pages.range }
%			    { type empty$
%			        { push.kap }
%			        { type }
%			      if$
%			      chapter tilde.or.space.connect
%			      pages empty$
%			        { skip$ }
%			        { ", " * push.pages.range * }
%			      if$
%			    }
%			  if$
%			}
			
			
%			FUNCTION {push.in.ed.booktitle}
%			% main title and volume
%			{ booktitle empty$
%			    { "" }
%			    { push.in " " * 
%			      editor empty$
%			        { skip$ }
%			        { push.editors * ": " * }
%			      if$
%			      booktitle format.emphasize * 
%			      volume empty$
%			        { skip$ }
%			        { " " * push.bd * "~" * volume * }
%			      if$
%			    }
%			  if$
%			}
			
			
FUNCTION {push.mastersthesis.type}
% push on stack: diplom, if type is empty, or masterthesis type
{ type empty$
    { push.diplom }             %% push diplom name on stack
    { type }                    %% push masterthesis type on stack
  if$
}
		
			
FUNCTION {push.phdthesis.type}
% push on stack: dissertation, if type is empty, or phdthesis type
{ type empty$
    { push.disser }             %% push dissertation name on stack
    { type }                    %% push phdthesis type on stack
  if$
}
			
			
%			FUNCTION {push.tr.number}
%			% type and number of a technical report
%			{ number empty$
%			    { " " }
%			    { "(" number * "). " * }
%			  if$
%			  "-- " *
%			  type empty$
%			    { push.forschung * }
%			    { type * }
%			  if$
%			}
			
			
FUNCTION {push.article.crossref}
% push on stack: either
% - if key and journal are null: empty String
% - if key is null: 'In: ' and formatted journal name
% - else: 'In: ' and key
% PLUS crossreference as citation PLUS page range, if pages is not empty
{ key empty$
    { journal empty$
        { "need key or journal for " cite$ * " to crossref " * crossref *
          warning$              %% warning about missing key or journal
          ""                    %% push empty String on stack
        }
        { push.in               %% push 'In:' String on stack
          " " *                 %% add to top of stack
          journal               %% push journal name on stack
          format.emphasize      %% format top item of stack as emphasized
          *                     %% join to two items on stack
        }
      if$
    }
    { push.in                   %% push 'In:' String on stack
      " " *                     %% add to top of stack
      key *                     %% push key on stack
     }
  if$
  " " *                         %% add to top of stack
  push.cite *                   %% add citation to top of stack
  "{" *                         %% add to top of stack
  crossref *                    %% add crossreference to top of stack
  "}" *                         %% add to top of stack
  pages empty$
    { skip$ }
    { ", " *                    %% add to top of stack
      push.pages.range *        %% add page range to top of stack
    }
  if$
}

			
FUNCTION {push.book.crossref}
% push on stack: either
% - if volume is null: 'siehe'
% - else: volume and 'von'
% PLUS crossreference as citation
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
                                %% warning about missing volume
      push.siehe                %% push 'siehe' String on stack
    }
    { push.bd                   %% push 'Band' String on stack
      "~" *                     %% add to top of stack
      volume *                  %% add volume to top of stack
      " " *                     %% add to top of stack
      push.von *                %% add 'von' String to top of stack
    }
  if$
  " " *                         %% add to top of stack
  push.cite *                   %% add cite method to top of stack
  "{" *                         %% add to top of stack
  crossref *                    %% add crossreference key to top of stack
  "}" *                         %% add to top of stack
}
			
			
%			FUNCTION {push.incoll.inproc.crossref}
%			% crossreference with In:
%			{ editor empty$
%			  editor push.field.or.null author push.field.or.null =
%			  or
%			    { key empty$
%			        { booktitle empty$
%			            { push.siehe }
%			            { push.in " " * booktitle format.emphasize * "." * }
%			          if$
%			        }
%			        { push.in }
%			      if$
%			    }
%			    { push.in }
%			  if$
%			  " " * push.cite * "{" * crossref * "}" *
%			  chapter empty$
%			    { skip$ }
%			    { ", " *
%			      type empty$
%			        { push.kap * }
%			        { type * }
%			      if$
%			      chapter tilde.or.space.connect
%			    }
%			  if$
%			  pages empty$
%			    { skip$ }
%			    { ", " * push.pages.range * }
%			  if$
%			}
			
			
FUNCTION {push.crossref}
% push on stack: empty String, if crossreference is null, or 'siehe' and 
% crossreference as citation
{ crossref empty$
    { "" }                      %% push empty String on stack
    { push.siehe                %% push 'siehe' String on stack
      " " *                     %% add to top of stack
      push.cite *               %% add citation to top of stack
      "{" *                     %% add to top of stack
      crossref *                %% add crossreference to top of stack
      "}" *                     %% add to top of stack
    }
  if$
}


%%------------------------------------------------------------------------------
%% functions for the different entries 
%%------------------------------------------------------------------------------

FUNCTION {article}
% required: author, title, journal, year, volume
% optional: number, pages, month, note, url, issn
{ out.bibitem.start             %% start bibitem in *.bbl file
  push.authors                  %% push author names on stack
  "author"                      %% push String for warning message on stack
  out.colon.check.required      %% either write to file with an appended colon or
                                %% give a warning if the stack is empty
  push.title.formatted          %% push formatted title on stack
  "title"                       %% push String for warning message on stack
  out.period.check.required     %% either write to file with an appended period
                                %% or give a warning if the stack is empty
  crossref missing$
    { push.article.in.journal   %% push source of article on stack
      " " *                     %% add to top of stack
      push.vol.year.num.pages * %% add to top of stack
    }
    { push.article.crossref }   %% push crossreference on stack
  if$
  out.period.check              %% write to file with an appended period, but
                                %% only if the stack is not empty
  url empty$
    { skip$ }
    { "-- "                     %% push dash on stack (no space before it)
      push.url *                %% add URL to top of stack
      out.block.space           %% write to file (no check because we know that
                                %% URL is not empty)
    }
  if$
  note empty$
    { skip$ }
    { "-- "                     %% push dash on stack
      note *                    %% add note to top of stack
      out.block.space           %% write to file (no check because we know that
                                %% note is not empty)
    }
  if$
  isbn empty$
  issn empty$
  and
    { skip$ }
    { "-- "                     %% push dash on stack
      push.isbn.issn            %% push ISBN or ISSN on stack
      out.block.space           %% write to file (no check because we know that
                                %% ISBN/ISSN is not empty)
    }
  if$  
  out.bibitem.end               %% end bibitem in *.bbl file
}
			
			
FUNCTION {book}
% required: author/editor, title, publisher, year
% optional: volume oder number, series, address, edition, pages, month, note, 
%           url, isbn
{ out.bibitem.start             %% start bibitem in *.bbl file
  author empty$
    { push.editors }            %% push editor names on stack
    { push.authors.editors }    %% push author and editor names on stack
  if$
  "author and editor"       %% push String for warning message on stack
  out.colon.check.required      %% either write to file with an appended colon or
                                %% give a warning if the stack is empty
  crossref missing$
    { push.title.series.volume }
                                %% push title, series and volume on stack
    { push.title.formatted }    %% push formatted title on stack
  if$ 
  "title"                       %% push String for warning message on stack
  out.period.check.required     %% either write to file with an appended period
                                %% or give a warning if the stack is empty
  push.edition                  %% push edition on stack
  out.period.check              %% write to file with an appended period, but
                                %% only if the stack is not empty
  push.address.publisher.year   %% push address, publisher and year on stack
  "publisher"                   %% push String for warning message on stack
  out.period.check.required     %% either write to file with an appended period
                                %% or give a warning if the stack is empty
  crossref missing$
    { push.series.number }      %% push series and number on stack
    { push.book.crossref }      %% push crossreference to series on stack
  if$
  out.period.check              %% write to file with an appended period, but
                                %% only if the stack is not empty
  push.pages.count              %% push pages of book on stack
  out.period.check              %% write to file with an appended period, but
                                %% only if the stack is not empty
  address empty$
  publisher empty$
  and
    { skip$ }
    { url empty$
        { skip$ }
        { "-- "                 %% push dash on stack (no space before it)
          push.url *            %% add URL to top of stack
          out.block.space       %% write to file (no check because we know that
                                %% URL is not empty)
        }
      if$
    }
  if$
  note empty$
    { skip$ }
    { "-- "                     %% push dash on stack
      note *                    %% add note to top of stack
      out.block.space           %% write to file (no check because we know that
                                %% note is not empty)
    }
  if$
  isbn empty$
  issn empty$
  and
    { skip$ }
    { "-- "                     %% push dash on stack
      push.isbn.issn            %% push ISBN or ISSN on stack
      out.block.space           %% write to file (no check because we know that
                                %% ISBN/ISSN is not empty)
    }
  if$  
  out.bibitem.end               %% end bibitem in *.bbl file
}
			
			
% booklet see below


% conference see below
			
			
%			FUNCTION {inbook}
%			% required: author/editor, title, chapter/pages, publisher, year
%			% optional: volume oder number, series, type, address, month, note, url, isbn
%			{ out.bibitem.start
%			  author empty$
%			    { push.editors "author and editor" out.check.required }
%			    { push.authors out.block }
%			  if$
%			  set.colon.after
%			  push.title.series.volume "title" out.check.required
%			  push.chapter.pages out.check
%			  crossref missing$
%			    { push.in.ed.booktitle "booktitle" out.check.required
%			      address empty$
%			        { part.of.sentence
%				  push.address.publisher.year out.check
%				}
%				{ push.address.publisher.year "publisher" out.check.required }
%			      if$
%			      new.sentence
%			      series empty$
%			        { skip$ }
%			        { push.series.number out.check }
%			      if$
%			      part.of.sentence
%			      address empty$
%			      publisher empty$
%			      and
%			        { skip$ }
%			        { push.period * push.url out.check
%			        }
%			      if$
%			    }
%			    { push.crossref out.block   
%			      push.period * push.url out.check
%			    }
%			  if$
%			  note set.period.dash.check
%			  note out.check
%			  isbn set.period.dash.check
%			  push.isbn.issn out.check
%			  out.bibitem.end
%			}
			
			
%			FUNCTION {incollection}
%			% required: author, title, booktitle, publisher, year
%			% optional: editor, volume oder number, series, type, chapter, 
%			%           pages, address, edition, month, note, url
%			{ out.bibitem.start
%			  push.authors "author" out.check.required
%			  set.colon.after
%			  push.title "title" out.check.required
%			  crossref missing$
%			    { push.in.ed.booktitle "booktitle" out.check.required
%			      push.edition out.check
%			      push.address.publisher.year "publisher" out.check.required
%			      new.sentence
%			      push.series.number out.check
%			      part.of.sentence
%			      push.chapter.pages "pages" out.check.required
%			      address empty$
%			      publisher empty$
%			      and
%			        { skip$ }
%			        { push.period * push.url out.check
%			        }
%			      if$
%			    }
%			    { push.incoll.inproc.crossref out.block 
%			      push.period * push.url out.check
%			    }
%			  if$
%			  note set.period.dash.check
%			  note out.check
%			  isbn set.period.dash.check
%			  issn set.period.dash.check
%			  push.isbn.issn out.check
%			  out.bibitem.end
%			}
			
			
FUNCTION {inproceedings}
% required: author, title, booktitle, year
% optional: editor, volume oder number, series, pages, address, month, 
%           organization, publisher, note, url
{ out.bibitem.start             %% start bibitem in *.bbl file
%			  push.authors "author" out.check.required
%			  set.colon.after
%			  push.title "title" out.check.required
%			  crossref missing$
%			    { push.in.ed.booktitle "booktitle" out.check.required
%			      address empty$
%			        { organization new.sentence.check
%			          push.organization out.check
%			          part.of.sentence
%			          push.address.publisher.year out.check
%			        }
%			        { push.address.publisher.year "publisher" out.check.required }
%			      if$
%			      new.sentence
%			      series empty$
%			        { skip$ }
%			        { push.series.number out.check }
%			      if$
%			      part.of.sentence
%			      push.pages.range "pages" out.check.required
%			      address empty$
%			      publisher empty$
%			      and
%			        { skip$ }
%			        { push.period * push.url out.check
%			        }
%			      if$
%			    }
%			    { push.incoll.inproc.crossref out.block 
%			      push.period * push.url out.check
%			    }
%			  if$
%			  note set.period.dash.check
%			  note out.check
%			  isbn set.period.dash.check
%			  issn set.period.dash.check
%			  push.isbn.issn out.check
  out.bibitem.end               %% end bibitem in *.bbl file
}
			
			
FUNCTION {internet}
% required: author or organization, title, url, urldate
% optional: year, note
{ out.bibitem.start             %% start bibitem in *.bbl file
  author empty$
    { push.organization.noorg } %% push organization name on stack
    { push.authors }            %% push author names on stack
  if$  
  "author or organization"      %% push String for warning message on stack
  out.colon.check.required      %% either write to file with an appended colon or
                                %% give a warning if the stack is empty
  push.title.formatted          %% push formatted title on stack
  "title"                       %% push String for warning message on stack
  out.period.check.required     %% either write to file with an appended period
                                %% or give a warning if the stack is empty
  year empty$
    { skip$ }
    { push.date                 %% push date on stack
      out.block.period          %% write to file (no check because we know that
                                %% year is not empty)
    }
  if$
  url empty$
    { "" }                      %% push empty String on stack
    { push.url }                %% add URL to top of stack
  if$
  "URL"                         %% push String for warning message on stack
  out.space.check.required      %% either write to file with an appended space or
                                %% give a warning if the stack is empty
  note empty$
    { skip$ }
    { "-- "                     %% push dash on stack
      note *                    %% add note to top of stack
      out.block.space           %% write to file (no check because we know that
                                %% note is not empty)
    }
  if$
  out.bibitem.end               %% end bibitem in *.bbl file
}


FUNCTION {manual}
% required: title
% optional: author, organization, address, edition, month, year, note, url
{ out.bibitem.start             %% start bibitem in *.bbl file
  author empty$
    { organization empty$
        { skip$ }
      	{ push.organization.noorg
                                %% push organization on stack
      	  out.block.colon       %% write to file (no check because we know that
                                %% organization is not empty)
	      }
      if$
    }
    { push.authors              %% push authors on stack
      out.block.colon           %% write to file (no check because we know that
                                %% author is not empty)
    }
  if$
  push.title.formatted          %% push formatted title on stack
  "title"                       %% push String for warning message on stack
  out.period.check.required     %% either write to file with an appended period
                                %% or give a warning if the stack is empty
  push.edition                  %% push edition on stack
  out.period.check              %% write to file with an appended period, but
                                %% only if the stack is not empty
  author empty$ 
    % author == empty -> organization was already used instead of author 
    { address empty$
        { "" }                  %% push empty String on stack
        { address               %% push address on stack
          year empty$
          month empty$
          and
            { skip$ }
            { ", " * }          %% add to top of stack
          if$
        }
      if$
    }
    % author != empty -> organization was not already used
    { address empty$
        { "" }                  %% push empty String on stack
        { address               %% push address on stack
          organization empty$
            { skip$ }
            { ": " * }          %% add to top of stack
          if$            
        }
      if$
      organization empty$
        { skip$ }
        { push.organization.noorg *
                                %% add organization to top of stack
        }                                
	    if$
      year empty$
      month empty$
      and
        { skip$ }
        { ", " * }              %% add to top of stack
      if$      
    }
  if$
  push.date *                   %% add date to top of stack
  out.period.check              %% write to file with an appended period, but
                                %% only if the stack is not empty   
  push.pages.count              %% push page count of manual on stack
  out.period.check              %% write to file with an appended period, but
                                %% only if the stack is not empty
  url empty$
    { skip$ }
    { "-- "                     %% push dash on stack (no space before it)
      push.url *                %% add URL to top of stack
      out.block.space           %% write to file (no check because we know that
                                %% URL is not empty)
    }
  if$
  note empty$
    { skip$ }
    { "-- "                     %% push dash on stack
      note *                    %% add note to top of stack
      out.block.space           %% write to file (no check because we know that
                                %% note is not empty)
    }
  if$
  out.bibitem.end               %% end bibitem in *.bbl file
}
			
			
FUNCTION {mastersthesis}
% required: author, title, school, year
% optional: type, address, month, note, url
{ out.bibitem.start             %% start bibitem in *.bbl file
  push.authors                  %% push author name on stack
  "author"                      %% push String for warning message on stack
  out.colon.check.required      %% either write to file with an appended colon or
                                %% give a warning if the stack is empty
  push.title.formatted          %% push formatted title on stack
  "title"                       %% push String for warning message on stack
  out.period.check.required     %% either write to file with an appended period
                                %% or give a warning if the stack is empty
  school empty$
  year empty$
  or
    { "empty school or year in " * cite$ * warning$ }
                                %% warning about missing school or year
    { address empty$
        { "" }                  %% push empty String on stack
        { address               %% push address on stack
          ": " *                %% add to top of stack
        }
      if$        
      school *                  %% add school name to top of stack
      ", " *                    %% add to top of stack     
      push.mastersthesis.type * %% add type of mastersthesis to top of stack
      push.date *               %% add year and month to top of stack
      out.block.period          %% write to file with an appended period (no 
                                %% check because we know that it is not empty)
    } 
  if$
  push.pages.count              %% push page count on stack
  out.space.check               %% write to file with an appended space, but
                                %% only if the stack is not empty
  url empty$
    { skip$ }
    { "-- "                     %% push dash on stack (no space before it)
      push.url *                %% add URL to top of stack
      out.block.space           %% write to file (no check because we know that
                                %% URL is not empty)
    }
  if$
  note empty$
    { skip$ }
    { "-- "                     %% push dash on stack
      note *                    %% add note to top of stack
      out.block.space           %% write to file (no check because we know that
                                %% note is not empty)
    }
  if$
  out.bibitem.end               %% end bibitem in *.bbl file
}
			
			
FUNCTION {misc}
% required: note or title AND author, editor or organization 
% optional: author, editor, title, howpublished, month, year, note, url
{ out.bibitem.start             %% start bibitem in *.bbl file
  note empty$
    { title empty$ 
        { skip$ }
        { push.authors.editors  %% push author and editor names on stack
          out.colon.check       %% write to file with an appended colon, but
                                %% only if the stack is not empty
          push.title.formatted  %% push formatted title on stack
          out.period.check      %% write to file with an appended period, but
                                %% only if the stack is not empty
          howpublished          %% push howpublished field on stack
          out.period.check      %% write to file with an appended period, but
                                %% only if the stack is not empty
				  push.date             %% push date on stack
				  out.period.check      %% write to file with an appended period, but
				                        %% only if the stack is not empty
	        push.crossref         %% push crossreference on stack
				  out.period.check      %% write to file with an appended period, but
				                        %% only if the stack is not empty
          url empty$
            { skip$ }
            { "-- "             %% push dash on stack (no space before it)
              push.url *        %% add URL to top of stack
              out.block.space   %% write to file (no check because we know that
                                %% URL is not empty)
            }
          if$
        } 
      if$
    }
    { note #1 #4 substring$ "u" change.case$ "NORM" =
        { note                  %% push note on stack
          out.period.check      %% write to file with an appended period, but
				                        %% only if the stack is not empty
          push.date             %% push date on stack
          out.period.check      %% write to file with an appended period, but
				                        %% only if the stack is not empty
          push.title.formatted  %% push formatted title on stack
          out.period.check      %% write to file with an appended period, but
				                        %% only if the stack is not empty
          push.crossref         %% push crssreference on stack
          out.space.check       %% write to file with an appended space, but
				                        %% only if the stack is not empty
        }
        { author empty$
            { editor empty$
                { organization empty$
                    { skip$ }
                    { push.organization
                                %% push organization name on stack
                      out.colon.check
                                %% write to file with an appended colon, but
                                %% only if the stack is not empty
                    }
                  if$
                } 
                { push.editors  %% push editor names on stack 
                  organization empty$
                    { skip$ }
                    { "; " *    %% add separator to top of stack
                      push.organization *
                                %% add organization to top of stack
                    }
                  if$
                  out.colon.check
                                %% write to file with an appended colon, but
                                %% only if the stack is not empty
                }
              if$
            } 
            { push.authors.editors
                                %% push author and editor names on stack
              out.colon.check
                                %% write to file with an appended colon, but
                                %% only if the stack is not empty
            }
          if$
          push.title.formatted  %% push formatted title on stack
          out.period.check      %% write to file with an appended period, but
                                %% only if the stack is not empty
	        push.crossref         %% push crossreference on stack
				  out.period.check      %% write to file with an appended period, but
				                        %% only if the stack is not empty
          howpublished          %% push howpublished field on stack
          out.period.check      %% write to file with an appended period, but
                                %% only if the stack is not empty
				  push.date             %% push date on stack
				  out.period.check      %% write to file with an appended period, but
				                        %% only if the stack is not empty
          push.series.parenth   %% push series in parentheses on stack
				  out.period.check      %% write to file with an appended period, but
				                        %% only if the stack is not empty
          url empty$
            { skip$ }
            { "-- "             %% push dash on stack (no space before it)
              push.url *        %% add URL to top of stack
              out.block.space   %% write to file (no check because we know that
                                %% URL is not empty)
            }
          if$
          note empty$
            { skip$ }
            { "-- "             %% push dash on stack
              note *            %% add note to top of stack
              out.block.space   %% write to file (no check because we know that
                                %% note is not empty)
            }
          if$
        }
      if$
    }
  if$  
  out.bibitem.end               %% end bibitem in *.bbl file
}
			
		
FUNCTION {phdthesis}
% required: author, title, school, year
% optional: type, address, month, note, url
{ out.bibitem.start             %% start bibitem in *.bbl file
  push.authors                  %% push author name on stack
  "author"                      %% push String for warning message on stack
  out.colon.check.required      %% either write to file with an appended colon or
                                %% give a warning if the stack is empty
  push.title.formatted          %% push formatted title on stack
  "title"                       %% push String for warning message on stack
  out.period.check.required     %% either write to file with an appended period
                                %% or give a warning if the stack is empty
  school empty$
  year empty$
  or
    { "empty school or year in " * cite$ * warning$ }
                                %% warning about missing school or year
    { address empty$
        { "" }                  %% push empty String on stack
        { address               %% push address on stack
          ": " *                %% add to top of stack
        }
      if$        
      school *                  %% add school name to top of stack
      ", " *                    %% add to top of stack     
      push.phdthesis.type *     %% add type of phdthesis to top of stack
      push.date *               %% add year and month to top of stack
      out.block.period          %% write to file with an appended period (no 
                                %% check because we know that it is not empty)
    } 
  if$
  push.pages.count              %% push page count on stack
  out.space.check               %% write to file with an appended space, but
                                %% only if the stack is not empty
  url empty$
    { skip$ }
    { "-- "                     %% push dash on stack (no space before it)
      push.url *                %% add URL to top of stack
      out.block.space           %% write to file (no check because we know that
                                %% URL is not empty)
    }
  if$
  note empty$
    { skip$ }
    { "-- "                     %% push dash on stack
      note *                    %% add note to top of stack
      out.block.space           %% write to file (no check because we know that
                                %% note is not empty)
    }
  if$
  out.bibitem.end               %% end bibitem in *.bbl file
}
		
			
%			FUNCTION {proceedings}
%			% required: title, year
%			% optional: editor, volume oder number, series, address, month, 
%			%           organization, publisher, note, url
%			{ out.bibitem.start
%			  editor empty$
%			    { push.organization }
%			    { push.editors
%			      organization empty$
%			        { skip$ }
%				{ "~; " * push.organization * }
%			      if$ 
%			    }
%			  if$
%			  out.block
%			  set.colon.after
%			  push.title.formatted "title" out.check.required
%			  volume empty$
%			    { skip$ } 
%			    { push.bd "~" * volume format.emphasize * out.block }
%			  if$
%			  push.address.publisher.year "publisher" out.check.required
%			  push.series.number out.check
%			  pages set.period.dash.check
%			  push.pages.count out.check
%			  address empty$
%			  publisher empty$
%			  and
%			    { skip$ }
%			    { push.period * push.url out.check
%			    }
%			  if$
%			  note set.period.dash.check
%			  note out.check
%			  isbn set.period.dash.check
%			  issn set.period.dash.check
%			  push.isbn.issn out.check
%			  out.bibitem.end
%			}
			
			
%			FUNCTION {techreport}
%			% required: author, title, institution, year
%			% optional: type, number, address, month, note, url
%			{ out.bibitem.start
%			  author empty$
%			    { push.editors "author and editor" out.check.required }
%			    { push.authors.editors out.block }
%			  if$
%			  set.colon.after
%			  push.title "title" out.check.required
%			  institution empty$
%			     { skip$ }
%			     { institution new.sentence.check
%			       "/ " institution * out.block 
%			     }
%			  if$
%			  push.address.publisher.year out.check
%			  number new.sentence.check
%			  push.tr.number "number" out.check.required
%			  pages set.period.dash.check
%			  push.pages.count out.check
%			  address empty$
%			  publisher empty$
%			  and
%			    { skip$ }
%			    { push.period * push.url out.check
%			    }
%			  if$
%			  note "note" out.check.required
%			  isbn set.period.dash.check
%			  issn set.period.dash.check
%			  push.isbn.issn out.check
%			  out.bibitem.end
%			}
			
			
FUNCTION {booklet} 
% required: title (not checked)
% optional: author, howpublished, address, month, year, note, url
{ misc }                        %% no type of its own so far
			
			
FUNCTION {conference} 
% required: author, title, note
% optional: month, year, url
{ inproceedings }               %% like stated in BibTeXing by O. Patashnik


FUNCTION {masterthesis}
% required: author, title, school, year
% optional: type, address, month, note, url
{ mastersthesis }               %% needed just because of a typo in former version


FUNCTION {unpublished} 
% required: author, title, note (not checked)
% optional: month, year, url
{ misc }                        %% no type of its own so far


FUNCTION {default.type} 
% required:
%optional: see misc
{ misc }                        %% all other types


%%------------------------------------------------------------------------------
%% for producing the labels
%%------------------------------------------------------------------------------

      %% just here to keep functions working that haven't been rewritten yet
			FUNCTION {push.field.or.null}
			% push an empty item on the stack if it's a missing entry
			{ duplicate$ empty$
			    { pop$ "" }
			    { skip$ }
			  if$
			}

			FUNCTION {sortify}
			% simplify for sorting
			{ purify$
			  "l" change.case$
			}
			
			
			FUNCTION {chop.word}
			% cut a word
			{ 's :=
			  'len :=
			  s #1 len substring$ =
			    { s len #1 + global.max$ substring$ }
			    { s }
			  if$
			}
			
			
FUNCTION {chop.article}
% cut article from a title
{ 't :=
  "A " #2
    "An " #3
      "Der " #4
        "Die " #4
          "Das " #4
            "Ein " #4
              "Eine " #5 
                  "The " #4 
                    t 
                  chop.word
               chop.word
             chop.word
           chop.word
         chop.word
       chop.word
    chop.word
  chop.word
}


			FUNCTION {format.lab.names}
			% format names for the label
			{ 's :=
			  s #1 "{vv~}{ll}" format.name$
			  s num.names$ duplicate$
			  #2 >
			    { pop$ " " * push.ua * }
			    { #2 <
			        { skip$ }
			        { s #2 "{ll}" format.name$ "others" =
			            { " " * push.ua * }
			            { " " * push.und * " " * s #2 "{vv~}{ll}" format.name$ * }
			          if$
			        }
			      if$
			    }
			  if$
			}
			
			FUNCTION {author.label}
			% label from key or author
			{ key empty$
			    { author empty$
			        { cite$ }
			        { author format.lab.names }
			      if$
			    }	
			    { key }
			  if$
			}
			
			FUNCTION {author.editor.label}
			% label from key, author or editor
			{ key empty$
			    { author empty$
			        { editor empty$
				          { cite$ }
				          { editor format.lab.names }
				        if$  
			        }
			        { author format.lab.names }
			      if$
			    }
			    { key }
			  if$
			}
			
			FUNCTION {author.organization.label}
			% label from key, author or organization
			{ key empty$
			    { author empty$
			        { organization empty$
				    { cite$ }
				    { organization chop.article }
				  if$  
			        }
			        { author format.lab.names }
			      if$
			    }
			    { key }
			  if$
			}
			
			FUNCTION {editor.organization.label}
			% label from key, editor or organization
			{ key empty$
			    { editor empty$
				{ organization empty$
				    { cite$ }
				    { organization chop.article }
				  if$
				}
			        { editor format.lab.names }
			      if$
			    }
			    { key }
			  if$
			}
			
			FUNCTION {calc.short.authors}
			% make short label (only first author)
			{ type$ "book" =
			  type$ "inbook" =
			  or
			    { author.editor.label }
			    { type$ "proceedings" =
				{ editor.organization.label }
				{ type$ "manual" =
				    { author.organization.label }
				    { author.label }
				  if$
				}
			      if$
			    }
			  if$
			  'short.list :=
			}
			
			
			FUNCTION {calc.label}
			% make a full label
			{ calc.short.authors
			  short.list "(" *
			  % vorher: year push.field.or.null format.dashes * 'label :=
			  "" push.field.or.null format.dashes * ")" * 'label :=
			  short.list "" *
			  % vorher: year push.field.or.null format.dashes * 'dinat.label :=  
			  format.dashes 'dinat.label :=  
			  label sortify 'sort.label :=
			}


%%------------------------------------------------------------------------------
%% sorting
%%------------------------------------------------------------------------------

			FUNCTION {sort.format.names}
			% format names for sorting
			{ 's :=
			  #1 'nameptr :=
			  ""
			  s num.names$ 'namesleft :=
			  { namesleft #0 > } % while
			     { nameptr #1 =
			         { skip$ }
			         { "   " * }
			       if$
			       s nameptr "{ll{ }}{  ff{ }}{ vv{ }}{  jj{ }}" format.name$ 't :=
			       namesleft #1 = 
			       t "others" = 
			       and
				 { "[" * push.ua * "]" * }
			         { t sortify * }
			       if$
			       nameptr #1 + 'nameptr :=
			       namesleft #1 - 'namesleft :=
			     }
			  while$ % { namesleft #0 > }
			}
			
			FUNCTION {sort.format.title}
			% format title for sorting (without article)
			{ chop.article
			  sortify
			  #1 global.max$ substring$
			}
			
			FUNCTION {author.sort}
			% author or key for sorting
			{ key empty$
			    { author empty$
				{ "to sort, need author or key in " cite$ * warning$
				  ""
				}
				{ author sort.format.names }
			      if$
			    }
			    { key sortify }
			  if$
			}
			
			FUNCTION {author.editor.sort}
			% author, editor or key for sorting
			{ key empty$
			    { author empty$
				{ editor empty$
				    { "to sort, need author, editor, or key in " cite$ * warning$
				      ""
				    }
				    { editor sort.format.names }
				  if$
				}
				{ author sort.format.names }
			      if$
			    }
			    { key sortify }
			  if$
			}
			
			FUNCTION {author.organization.sort}
			% author, organization or key for sorting
			{ key empty$
			    { author empty$
				{ organization empty$
				    { "to sort, need author, organization, or key in " cite$ * warning$
				      ""
				    }
				    { organization chop.article sortify }
				  if$
				}
				{ author sort.format.names }
			      if$
			    }
			    { key sortify }
			  if$
			}
			
			FUNCTION {editor.organization.sort}
			% editor, organization or key for sorting
			{ key empty$
			    { editor empty$
				{ organization empty$
				    { "to sort, need editor, organization, or key in " cite$ * warning$
				      ""
				    }
				    { organization chop.article sortify }
				  if$
				}
				{ editor sort.format.names }
			      if$
			    }
			    { key sortify }
			  if$
			}
			
			FUNCTION {presort}
			% first sort 
			{ calc.label
			  sort.label
			  "    " *
			  type$ "book" =
			  type$ "inbook" =
			  or
			    { author.editor.sort }
			    { type$ "proceedings" =
				{ editor.organization.sort }
				{ type$ "manual" =
				    { author.organization.sort }
				    { author.sort }
				  if$
				}
			      if$
			    }
			  if$
			  "    " *
			  year push.field.or.null sortify *  
			  "    " *
			  title push.field.or.null sort.format.title *
			  #1 entry.max$ substring$
			  'sort.label :=
			  sort.label *
			  #1 entry.max$ substring$
			  'sort.key$ :=
			}
			
			STRINGS { last.label next.extra }
			
			INTEGERS { last.extra.num label.count }
			
			FUNCTION {initialize.label}
			{ "" 'last.label :=
			  #0 'label.count :=
			}
			
			FUNCTION {forward.pass}
			% find maximum additional character for identical labels
			{ last.label label =
			    { last.extra.num #1 + 'last.extra.num :=
			      last.extra.num int.to.chr$ 'extra.label :=
			    }
			    { "a" chr.to.int$ 'last.extra.num :=
			      "" 'extra.label :=
			      label 'last.label :=
			    }
			  if$
			  label.count #1 + 'label.count :=
			}
			
			FUNCTION {reverse.pass}
			% add additional characters to identical labels
			{ next.extra "b" =
			    { "a" 'extra.label := }
			    { skip$ }
			  if$
			  extra.label 'next.extra :=
			  extra.label empty$
			    { "" }
			    { "{\natexlab{" extra.label * "}}" * }
			  if$
			  'extra.label :=
			  label extra.label * 'label :=
			  dinat.label extra.label * 'dinat.label :=
			}
			
			FUNCTION {bib.sort.order}
			{ sort.label 'sort.key$ :=
			}


%%------------------------------------------------------------------------------
%% making the .bbl file
%%------------------------------------------------------------------------------

FUNCTION {begin.bib}
% beginning of the .bbl file
{ preamble$ empty$
    { skip$ }
    { preamble$ 
      write$                    %% pop from stack and write to file 
      newline$                  %% write newline in file 
    }
  if$
  "\begin{thebibliography}{"    %% push on stack
  label.count int.to.str$ * "}" *  %% TODO ???
  write$                        %% pop from stack and write to file 
  newline$                      %% write newline in file
  "% this bibliography was produced with the style jr-dinat.bst v1.0"
  															%% push on stack
  write$                        %% pop from stack and write to file 
  newline$                      %% write newline in file
  "\makeatletter"               %% push on stack
  write$                        %% pop from stack and write to file 
  newline$                      %% write newline in file
  "\newcommand{\dinatlabel}[1]%"
                                %% push on stack 
  write$                        %% pop from stack and write to file 
  newline$                      %% write newline in file
  "{\ifNAT@numbers\else\NAT@biblabelnum{#1}\hspace{2\labelsep}\fi}"
                                %% push on stack
  write$                        %% pop from stack and write to file 
  newline$                      %% write newline in file
  "\makeatother"                %% push on stack
  write$                        %% pop from stack and write to file 
  newline$                      %% write newline in file
  "\expandafter\ifx\csname natexlab\endcsname\relax\def\natexlab#1{#1}\fi"
                                %% push on stack
  write$                        %% pop from stack and write to file 
  newline$                      %% write newline in file
  "\expandafter\ifx\csname url\endcsname\relax\def\url#1{\texttt{#1}}\fi"
                                %% push on stack
  write$                        %% pop from stack and write to file 
  newline$                      %% write newline in file
}


FUNCTION {end.bib}
% end of the .bbl file
{ newline$                      %% write newline in file
  "\end{thebibliography}"       %% push on stack
  write$                        %% pop from stack and write to file
  newline$                      %% write newline in file
}


%%------------------------------------------------------------------------------
%% processing the .bib file
%%------------------------------------------------------------------------------

READ

ITERATE {presort}

SORT

EXECUTE {initialize.label}

ITERATE {forward.pass}

REVERSE {reverse.pass}

ITERATE {bib.sort.order}

SORT

EXECUTE {begin.bib}

ITERATE {call.type$}

EXECUTE {end.bib}