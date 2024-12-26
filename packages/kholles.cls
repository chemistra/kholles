\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kholles}[Kholles class v 02.03.24]

\DeclareOption*{%
\PassOptionsToClass{\CurrentOption}{exam}
}
\ProcessOptions\relax

\LoadClass[11pt,a4paper]{exam}

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[french]{babel}
\RequirePackage{csquotes}
\RequirePackage{morefloats}
\RequirePackage{etoolbox}
\RequirePackage{graphicx}
\RequirePackage[export]{adjustbox}
\RequirePackage{pdfpages}
\RequirePackage[left=2cm,right=2cm,top=2cm,bottom=2cm]{geometry}
\RequirePackage{titlesec}
\RequirePackage{imakeidx}
\RequirePackage[backend=biber]{biblatex}
\RequirePackage{usebib}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{exercise}

\RequirePackage[arrowvec, mdvec, itvec, mecaflu, wedge]{physics2}

\RequirePackage{chemistry}
\RequirePackage{phystikz}

\RequirePackage{datetime}
\RequirePackage{totcount}


\newcommand{\textsfbf}[1]{\textbf{\textsf{#1}}}

\newcommand{\CCBY}{\smash{\raisebox{-1ex}{\href{https://creativecommons.org/licenses/by-nc-sa/4.0/}{\includegraphics[width=2.5cm]{CC.png}}}
}}

\makeatletter
\headrule
\header{\@title}{\@date}{\@author}
\footer{}{\CCBY}{\thepage}
\DeclareOption{nopagenumber}{
\footer{\@mail}{\CCBY}{}}
\ProcessOptions\relax
\makeatother

%Section style

\makeatletter
\newcommand\@twodigits[1]{%
   \ifnum#1<10 0#1%
   \else #1%
   \fi%
}
\newcommand\twodigits[1]{%
    \@twodigits{\arabic{#1}}%
}
\newcommand{\@arabicAlph}[1]{%
    \ifnum#1<10 #1%
    \else\@Alph{\the\numexpr#1-9\relax}%
    \fi%
}
\newcommand{\arabicAlph}[1]{%
    \@arabicAlph{\arabic{#1}}%
}
\makeatother

%\let\arabicAlph\arabic

\renewcommand{\thepart}{Partie \arabicAlph{part}.}
\renewcommand{\thesection}{§\arabicAlph{part}\arabicAlph{section}}
\renewcommand{\theexercise}{\arabicAlph{part}\arabicAlph{section}\hspace{2pt}\twodigits{exercise}}
\renewcommand{\theexerciseref}{\arabicAlph{part}\arabicAlph{section}\arabic{exercise}}
\renewcommand{\thefigure}{\arabic{exercise}.\arabic{figure}}
\renewcommand{\thetable}{\arabic{exercise}.\arabic{table}}
\renewcommand{\theequation}{\arabic{exercise}.\arabic{equation}}


\let\oldpart\part
\let\oldsection\section
\renewcommand{\part}{\newpage\addtocontents{toc}{\columnbreak}}
\renewcommand{\section}{\newpage~\vspace{-30pt}\oldsection}

\makeatletter
\newcommand{\@rot}[1]{\rotatebox{270}{#1}}
\definecolor{seccolor}{RGB}{121,50,111}
\titleformat{\section}[leftmargin]
  {\normalfont\Large\bfseries}{\color{seccolor}\@rot{\thesection ~}}{0em}{\color{seccolor}\@rot}
\titleformat{\subsection}
  {\normalfont\Large\bfseries\sffamily}{\thesubsection}{1em}{}
\titleformat{\paragraph}[runin]
  {\normalfont\large\bfseries\sffamily}{\theparagraph}{0ex}{}
\titlespacing*{\paragraph}{0ex}{1em}{1ex}
\makeatother


%Setup les captions
\captionsetup{font=normalfont,labelfont={sf,bf}}
\captionsetup[figure]{name={Figure}}
\captionsetup[table]{name={Table}}


%Reset les compteurs
\makeatletter
\@addtoreset{section}{part}
\@addtoreset{exercise}{section}
%\@removefromreset{subsection}{section}
\@addtoreset{figure}{exercise}
\@addtoreset{table}{exercise}
\@addtoreset{equation}{exercise}
\makeatother
%Counting
\newtotcounter{exos}
\def\oldexercise{} \let\oldexercise=\exercise
\def\exercise{\stepcounter{exos}\oldexercise}

%Index setup
%\patchcmd{\theindex}{\thispagestyle{plain}}{}{}{}

%List of exercises
\makeatletter
\renewcommand{\numberline}[1]{#1~}
\newcommand{\listofexercises}{%
    \subsection*{Liste des exercices}
    \begin{multicols}{2}
        \hyphenpenalty=10000
        \hbadness=10000
        \@starttoc{toc}
    \end{multicols}}
\makeatother



%%Nouvelle page de garde
\makeatletter

\def\mail#1{\gdef\@mail{\texttt{#1}}}
\gdef\@mail{\@latex@error{No \noexpand\mail given}\@ehc}

\let\@subtitle\empty
\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}}

\let\@editor\empty
\newcommand{\editor}[1]{\gdef\@editor{#1}}

\definecolor{fgcolor}{HTML}{0071BC}
\colorlet{bgcolor}{cyan!50!white}

\renewcommand{\maketitle}{

\ifprintanswers
\colorlet{fgcolor}{solcolor}
\colorlet{bgcolor}{solcolor!50!white}
\fi

\newgeometry{right=45mm,top=5mm,bottom=5mm,left=5mm}
\begin{titlepage}


\AddToShipoutPictureBG*{%
    \begin{tikzpicture}[remember picture,overlay]
    \fill[bgcolor, pos=0] (current page.north west) rectangle
    (current page.south east) {};
    \fill[fgcolor] (current page.north east) rectangle
    ([xshift=-40mm]current page.south east) {};
\end{tikzpicture}}

\raggedleft
\thispagestyle{empty}
\vspace*{\baselineskip}
{\large\@author}\\[0.167\textheight]

{\textcolor{fgcolor}{\bfseries\fontsize{10cm}{10cm}\selectfont\@title}}\\[\baselineskip]
{\textcolor{fgcolor}{\bfseries\huge 3\textsuperscript{ème} édition}}\\[2\baselineskip]
{\large \total{exos} exercices de khôlle de physique--chimie \ifprintanswers et leur corrections\fi}\\[2\baselineskip]
{\includegraphics[width=10cm]{packages/Maitre-Hibou.png}}\par
\vfill
{\Large Edition les Olympiades}\par
\vspace*{3\baselineskip}

\end{titlepage}

\restoregeometry
\pagecolor{white}
}

\newcommand{\frontmatter}{
\pagenumbering{roman}
\thispagestyle{headandfoot}}

\newcommand{\mainmatter}{
\pagenumbering{arabic}
    \thispagestyle{headandfoot}}

\makeatother


%Fiche d'exos
\newcommand{\answertitle}{}
\DeclareOption{answers}{\renewcommand{\answertitle}{\Large Correction}}
\DeclareOption{exercisesheet}{\input{exercisesheet.clo}}
\DeclareOption{noexercisenumber}{\let\theexerciselabel\relax}

\ExecuteOptions{}

\ProcessOptions\relax

\newcommand{\todo}[1][??]{{\colorbox{orange}{\textcolor{white}{#1}}}
    \marginpar{\colorbox{orange}{\textcolor{white}{!!}}}
}



%Margins short
\AtBeginDocument{
    \setlength{\abovedisplayskip}{1ex plus 1ex minus 1ex}
    \setlength{\belowdisplayskip}{1ex plus 1ex minus 1ex}
    \setlength{\abovedisplayshortskip}{0ex}
    \setlength{\belowdisplayshortskip}{0ex}
    
    \setlength{\intextsep}{1ex plus 1ex minus 1ex}
    \setlength{\abovecaptionskip}{1ex plus 1ex minus 1ex}
    \setlength{\belowcaptionskip}{0ex}
}

\makeindex
