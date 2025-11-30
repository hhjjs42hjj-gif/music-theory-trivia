\version "2.24.0"

\header {
  title = "Ethereal Whispers"
  subtitle = "A Delicate Piece for Strings and Woodwinds"
  composer = "Music Theory Trivia"
  tagline = "An expressive, ethereal, and tender composition"
}

% Global settings for the ethereal, delicate mood
global = {
  \key d \major
  \time 4/4
  \tempo "Adagio, con delicatezza" 4 = 56
}

% ============================================
% WOODWINDS
% ============================================

% Flute - Range: C4 to C7, using middle to upper register for ethereal quality
flute = \relative c'' {
  \global
  \clef treble
  
  % Opening - gentle, floating melody
  R1 |
  r2 fis4\pp( ~ \< fis8 g |
  a4\mp ~ a8 g fis4 e) |
  d2.\> r4\pp |
  
  % Phrase 2 - expressive cantabile
  r4 a'4\p\espressivo( ~ a8 b a g |
  fis4. e8 d4 cis) |
  b2(\< cis4 d) |
  e2.\mf( ~ e4)\> |
  
  % Phrase 3 - ethereal high register
  r2 fis'4\pp\(( ~ fis8 e |
  d4 cis b a)\) |
  g4.\<( a8 b4 cis)\! |
  d2.\p( ~ d4) |
  
  % Phrase 4 - delicate descent
  cis4\pp( b a g) |
  fis2.\fermata r4 |
  R1 |
  R1 \bar "|."
}

% Oboe - Range: Bb3 to G6, warm expressive middle register
oboe = \relative c' {
  \global
  \clef treble
  
  % Opening - tender sustained notes
  d2\pp ~ d4.( e8 |
  fis4. g8 a2) |
  r4 fis4\p( e d) |
  cis2.\> r4\pp |
  
  % Phrase 2 - lyrical response
  d4.\p( e8 fis4 g) |
  a2.( g4) |
  fis4\<( e fis g) |
  a2.\mf( ~ a4)\> |
  
  % Phrase 3 - sustained harmonies
  b2\pp\(( a4. g8) |
  fis2 e\) |
  d4.\<( e8 fis4 g)\! |
  a2.\p( ~ a4) |
  
  % Phrase 4 - gentle resolution
  g4\pp( fis e d) |
  cis2.\fermata r4 |
  R1 |
  R1 \bar "|."
}

% Clarinet in Bb - Range: E3 to C7 (written), using warm chalumeau and clarion
clarinet = \relative c' {
  \global
  \clef treble
  
  % Opening - warm, rounded tones
  R1 |
  d2\pp( e4. fis8) |
  g2.\p( fis4) |
  e2.\> r4\pp |
  
  % Phrase 2 - expressive line
  fis4.\p\espressivo( g8 a4 b) |
  a2( g4 fis) |
  e4\<( fis g a) |
  b2.\mf( ~ b4)\> |
  
  % Phrase 3 - tender melody
  a2\pp( g4. fis8) |
  e2( d) |
  cis4.\<( d8 e4 fis)\! |
  g2.\p( ~ g4) |
  
  % Phrase 4 - soft conclusion
  fis4\pp( e d cis) |
  d2.\fermata r4 |
  R1 |
  R1 \bar "|."
}

% Bassoon - Range: Bb1 to Eb5, providing warm bass foundation
bassoon = \relative c {
  \global
  \clef bass
  
  % Opening - gentle bass line
  d2\pp( a) |
  d2.( cis4) |
  b2.\p( a4) |
  d,2.\> r4\pp |
  
  % Phrase 2 - supportive bass
  d'4.\p( e8 fis4 g) |
  d2( e4 fis) |
  g4\<( fis e d) |
  a2.\mf( ~ a4)\> |
  
  % Phrase 3 - sustained foundation
  d2\pp( e4. fis8) |
  g2( a,) |
  d,4.\<( e8 fis4 g)\! |
  d2.\p( ~ d4) |
  
  % Phrase 4 - gentle close
  a4\pp( b cis d) |
  d,2.\fermata r4 |
  R1 |
  R1 \bar "|."
}

% ============================================
% STRINGS
% ============================================

% Violin I - Range: G3 to E7, lyrical high register
violinI = \relative c'' {
  \global
  \clef treble
  
  % Opening - floating, ethereal melody
  a4\pp\(( ~ a8 b a4 g) |
  fis4.( e8 d4 cis)\) |
  d4.\p\<( e8 fis4 g) |
  a2.\>\! r4\pp |
  
  % Phrase 2 - expressive, singing line
  fis'4.\p\espressivo( g8 a4 b) |
  a4( g fis e) |
  d4\<( e fis g) |
  a2.\mf( ~ a4)\> |
  
  % Phrase 3 - delicate arpeggios
  d,8\pp( e fis g a4 b) |
  a4( g fis e) |
  d4.\<( e8 fis4 g)\! |
  a2.\p( ~ a4) |
  
  % Phrase 4 - tender conclusion
  g4\pp( fis e d) |
  d2.\fermata r4 |
  R1 |
  R1 \bar "|."
}

% Violin II - Range: G3 to E7, supporting harmonies
violinII = \relative c' {
  \global
  \clef treble
  
  % Opening - gentle accompaniment
  fis4\pp( ~ fis8 g fis4 e) |
  d2( cis4 b) |
  a4.\p\<( b8 cis4 d) |
  fis2.\>\! r4\pp |
  
  % Phrase 2 - harmonic support
  d'4.\p( e8 fis4 g) |
  fis4( e d cis) |
  b4\<( cis d e) |
  fis2.\mf( ~ fis4)\> |
  
  % Phrase 3 - interweaving lines
  b,8\pp( cis d e fis4 g) |
  fis4( e d cis) |
  b4.\<( cis8 d4 e)\! |
  fis2.\p( ~ fis4) |
  
  % Phrase 4 - soft resolution
  e4\pp( d cis b) |
  a2.\fermata r4 |
  R1 |
  R1 \bar "|."
}

% Viola - Range: C3 to E6, warm inner voice
viola = \relative c' {
  \global
  \clef alto
  
  % Opening - sustained inner harmonies
  d4\pp( ~ d8 e d4 cis) |
  b2( a4 g) |
  fis4.\p\<( g8 a4 b) |
  d2.\>\! r4\pp |
  
  % Phrase 2 - expressive middle voice
  a'4.\p( b8 cis4 d) |
  cis4( b a g) |
  fis4\<( g a b) |
  cis2.\mf( ~ cis4)\> |
  
  % Phrase 3 - gentle movement
  g8\pp( a b cis d4 e) |
  d4( cis b a) |
  g4.\<( a8 b4 cis)\! |
  d2.\p( ~ d4) |
  
  % Phrase 4 - warm close
  cis4\pp( b a g) |
  fis2.\fermata r4 |
  R1 |
  R1 \bar "|."
}

% Cello - Range: C2 to C6, rich bass and tenor
cello = \relative c {
  \global
  \clef bass
  
  % Opening - warm bass foundation
  d2\pp( a) |
  d2.( e4) |
  fis4.\p\<( g8 a4 b) |
  a2.\>\! r4\pp |
  
  % Phrase 2 - singing bass line
  d,4.\p( e8 fis4 g) |
  a2( b4 cis) |
  d4\<( cis b a) |
  d,2.\mf( ~ d4)\> |
  
  % Phrase 3 - expressive cello melody
  g8\pp( a b cis d4 e) |
  d4( cis b a) |
  g4.\<( a8 b4 cis)\! |
  d2.\p( ~ d4) |
  
  % Phrase 4 - gentle resolution
  a4\pp( g fis e) |
  d2.\fermata r4 |
  R1 |
  R1 \bar "|."
}

% ============================================
% SCORE LAYOUT
% ============================================

\score {
  <<
    \new StaffGroup = "woodwinds" <<
      \new Staff \with {
        instrumentName = "Flute"
        shortInstrumentName = "Fl."
        midiInstrument = "flute"
      } \flute
      
      \new Staff \with {
        instrumentName = "Oboe"
        shortInstrumentName = "Ob."
        midiInstrument = "oboe"
      } \oboe
      
      \new Staff \with {
        instrumentName = "Clarinet in B♭"
        shortInstrumentName = "Cl."
        midiInstrument = "clarinet"
      } \clarinet
      
      \new Staff \with {
        instrumentName = "Bassoon"
        shortInstrumentName = "Bsn."
        midiInstrument = "bassoon"
      } \bassoon
    >>
    
    \new StaffGroup = "strings" <<
      \new Staff \with {
        instrumentName = "Violin I"
        shortInstrumentName = "Vn. I"
        midiInstrument = "string ensemble 1"
      } \violinI
      
      \new Staff \with {
        instrumentName = "Violin II"
        shortInstrumentName = "Vn. II"
        midiInstrument = "string ensemble 1"
      } \violinII
      
      \new Staff \with {
        instrumentName = "Viola"
        shortInstrumentName = "Vla."
        midiInstrument = "string ensemble 1"
      } \viola
      
      \new Staff \with {
        instrumentName = "Violoncello"
        shortInstrumentName = "Vc."
        midiInstrument = "string ensemble 1"
      } \cello
    >>
  >>
  
  \layout {
    \context {
      \Score
      % Enable consistent spacing for the delicate character
      \override SpacingSpanner.uniform-stretching = ##t
    }
    \context {
      \Staff
      % Use smaller note heads for delicate appearance
    }
  }
  
  \midi {
    \tempo 4 = 56
  }
}

% ============================================
% PERFORMANCE NOTES
% ============================================
\markup {
  \column {
    \line { \bold "Performance Notes:" }
    \line { "• This piece should be performed with utmost delicacy and sensitivity." }
    \line { "• All dynamics are soft (pp-mp) to maintain the fragile, ethereal character." }
    \line { "• Strings should use very light bow pressure with sul tasto coloring." }
    \line { "• Woodwinds should aim for a pure, transparent tone quality." }
    \line { "• Phrasing should be long and flowing, with gentle breaths." }
    \line { "• The tempo may be stretched slightly for expressive purposes (rubato)." }
    \line { "• Listen carefully and blend with the ensemble; no voice should dominate." }
  }
}
