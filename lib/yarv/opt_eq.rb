module YARV
  # ### Summary
  #
  # `opt_eq` is a specialization of the `opt_send_without_block` instruction
  # that occurs when the == operator is used. Fast paths exist within CRuby when
  # both operands are integers, floats, symbols or strings.
  #
  # ### TracePoint
  #
  # `opt_eq` can dispatch both the `c_call` and `c_return` events.
  #
  # ### Usage
  #
  # ~~~ruby
  # 2 == 2
  #
  # # == disasm: #<ISeq:<main>@-e:1 (1,0)-(1,6)> (catch: FALSE)
  # # 0000 putobject                              2                         (   1)[Li]
  # # 0002 putobject                              2
  # # 0004 opt_eq                                 <calldata!mid:==, argc:1, ARGS_SIMPLE>[CcCr]
  # # 0006 leave
  # ~~~
  #
  class OptEq
    def call(context)
      left, right = context.stack.pop(2)

      result = context.call_method(left, :==, [right])
      context.stack.push(result)
    end

    def pretty_print(q)
      q.text("opt_eq <calldata!mid:==, argc:1, ARGS_SIMPLE>")
    end
  end
end
