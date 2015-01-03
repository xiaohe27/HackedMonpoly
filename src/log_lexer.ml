# 39 "log_lexer.mll"
 
  open Misc
  open Lexing
  open Log_parser
    
  let f str lexbuf = 
    if Misc.debugging Dbg_log then
      let lxm = Lexing.lexeme lexbuf in
      let show = match lxm with
	| "\n" -> "\\n"
	| "\r" -> "\\r"
	| "\t" -> "\\t"
	| _ -> lxm
      in
	begin
	  Printf.printf "[Log_lexer]  %s is -%s- with " str show;
	  Printf.printf "abs=%d len=%d start=%d curr=%d last=%d start_p=%d curr_p=%d\n%!" 
	    lexbuf.lex_abs_pos lexbuf.lex_buffer_len lexbuf.lex_start_pos lexbuf.lex_curr_pos lexbuf.lex_last_pos
	    lexbuf.lex_start_p.pos_cnum lexbuf.lex_curr_p.pos_cnum
	end
    else
      ()

  let strip str = 
    let len = String.length str in
    if str.[0] = '\"' && str.[len-1] = '\"' then
      String.sub str 1 (len-2)
    else
      str

  let new_line lexbuf =
    let lcp = lexbuf.lex_curr_p in
    lexbuf.lex_curr_p <- 
      { lcp with
	pos_lnum = lcp.pos_lnum + 1;
	pos_bol = lcp.pos_cnum;
      }


# 42 "log_lexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base = 
   "\000\000\246\255\247\255\248\255\002\000\090\000\250\255\251\255\
    \252\255\253\255\001\000\254\255\255\255\249\255\003\000\004\000\
    \253\255\254\255\255\255";
  Lexing.lex_backtrk = 
   "\006\000\255\255\255\255\255\255\009\000\006\000\255\255\255\255\
    \255\255\255\255\001\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255";
  Lexing.lex_default = 
   "\001\000\000\000\000\000\000\000\014\000\255\255\000\000\000\000\
    \000\000\000\000\255\255\000\000\000\000\000\000\014\000\017\000\
    \000\000\000\000\000\000";
  Lexing.lex_trans = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\012\000\011\000\011\000\000\000\010\000\018\000\000\000\
    \000\000\018\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \012\000\005\000\004\000\003\000\013\000\013\000\000\000\000\000\
    \008\000\007\000\000\000\000\000\006\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\000\000\000\000\000\000\000\000\000\000\
    \009\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\000\000\005\000\000\000\005\000\
    \000\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\000\000\005\000\
    \000\000\005\000\000\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \002\000\000\000\255\255\255\255\016\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000";
  Lexing.lex_check = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\010\000\255\255\000\000\015\000\255\255\
    \255\255\015\000\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\000\000\000\000\000\000\004\000\014\000\255\255\255\255\
    \000\000\000\000\255\255\255\255\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\255\255\255\255\255\255\255\255\255\255\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\255\255\000\000\255\255\000\000\
    \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\005\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\255\255\005\000\
    \255\255\005\000\255\255\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\005\000\005\000\005\000\
    \005\000\005\000\005\000\005\000\005\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\004\000\014\000\015\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255";
  Lexing.lex_base_code = 
   "";
  Lexing.lex_backtrk_code = 
   "";
  Lexing.lex_default_code = 
   "";
  Lexing.lex_trans_code = 
   "";
  Lexing.lex_check_code = 
   "";
  Lexing.lex_code = 
   "";
}

let rec token lexbuf =
    __ocaml_lex_token_rec lexbuf 0
and __ocaml_lex_token_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 88 "log_lexer.mll"
                                        ( f "white space" lexbuf; token lexbuf )
# 167 "log_lexer.ml"

  | 1 ->
# 89 "log_lexer.mll"
                                 ( f "line break" lexbuf; new_line lexbuf; token lexbuf )
# 172 "log_lexer.ml"

  | 2 ->
# 90 "log_lexer.mll"
             ( f "TS" lexbuf; AT )
# 177 "log_lexer.ml"

  | 3 ->
# 91 "log_lexer.mll"
             ( f "LPA" lexbuf; LPA )
# 182 "log_lexer.ml"

  | 4 ->
# 92 "log_lexer.mll"
             ( f "RPA" lexbuf; RPA )
# 187 "log_lexer.ml"

  | 5 ->
# 93 "log_lexer.mll"
             ( f "COM" lexbuf; COM )
# 192 "log_lexer.ml"

  | 6 ->
let
# 95 "log_lexer.mll"
                lxm
# 198 "log_lexer.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 95 "log_lexer.mll"
                             ( f "STR" lexbuf; STR (strip lxm) )
# 202 "log_lexer.ml"

  | 7 ->
# 97 "log_lexer.mll"
                                        ( f "#" lexbuf; line_comment lexbuf )
# 207 "log_lexer.ml"

  | 8 ->
# 99 "log_lexer.mll"
             ( f "EOF" lexbuf; EOF )
# 212 "log_lexer.ml"

  | 9 ->
# 101 "log_lexer.mll"
                                        ( failwith "Illegal character in log file." )
# 217 "log_lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; __ocaml_lex_token_rec lexbuf __ocaml_lex_state

and line_comment lexbuf =
    __ocaml_lex_line_comment_rec lexbuf 15
and __ocaml_lex_line_comment_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 105 "log_lexer.mll"
                                ( f "end comment" lexbuf; token lexbuf )
# 228 "log_lexer.ml"

  | 1 ->
# 106 "log_lexer.mll"
                                ( f "any" lexbuf; line_comment lexbuf )
# 233 "log_lexer.ml"

  | 2 ->
# 107 "log_lexer.mll"
           ( f "eof" lexbuf; EOF )
# 238 "log_lexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; __ocaml_lex_line_comment_rec lexbuf __ocaml_lex_state

;;

