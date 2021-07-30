open! Core
open! Bonsai_web
open Memtrace_viewer_common

module Series : sig
  type t

  val create
    :  ?css_class:string
    -> max_x:Time_ns.Span.t
    -> max_y:float
    -> (Time_ns.Span.t * float) list
    -> t
end

module Region : sig
  type t

  val create : ?css_class:string -> Range.Time_ns_span.Or_empty.t -> t
end

module Time_view : sig
  type t =
    | Elapsed_seconds
    | Wall_time
  [@@deriving sexp, equal]
end

val component
  :  series:Series.t list Bonsai.Value.t
  -> regions:Region.t list Bonsai.Value.t
  -> width:int Bonsai.Value.t
  -> height:int Bonsai.Value.t
  -> start_time:Time_ns.t Bonsai.Value.t
  -> time_view:Time_view.t Bonsai.Value.t
  -> set_time_view:(Time_view.t -> unit Vdom.Effect.t) Bonsai.Value.t
  -> Vdom.Node.t Bonsai.Computation.t
