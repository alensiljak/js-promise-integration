(module
  (func "fac-expr" (param $n i64) (result i64)
    (local $i i64)
    (local $res i64)
    (set_local $i (get_local $n))
    (set_local $res (i64.const 1))
    (block $done
      (loop $loop
        (if
          (i64.eq (get_local $i) (i64.const 0))
          (br $done)
          (block
            (set_local $res (i64.mul (get_local $i) (get_local $res)))
            (set_local $i (i64.sub (get_local $i) (i64.const 1)))
          )
        )
        (br $loop)
      )
    )
    (get_local $res)
  )

  (func "fac-stack" (param $n i64) (result i64)
    (local $i i64)
    (local $res i64)
    get_local $n
    set_local $i
    i64.const 1
    set_local $res
    block $done
      loop $loop
        get_local $i
        i64.const 0
        i64.eq
        if
          br 0 $done
        else
          get_local $i
          get_local $res
          i64.mul
          set_local $res
          get_local $i
          i64.const 1
          i64.sub
          set_local $i
        end
        br 0 $loop
      end
    end
    get_local $res
  )

  (func "fac-mixed" (param $n i64) (result i64)
    (local $i i64)
    (local $res i64)
    (set_local $i (get_local $n))
    (set_local $res (i64.const 1))
    block $done
      loop $loop
        (i64.eq (get_local $i) (i64.const 0))
        if
          br 0 $done
        else
          (i64.mul (get_local $i) (get_local $res))
          set_local $res
          (i64.sub (get_local $i) (i64.const 1))
          set_local $i
        end
        br 0 $loop
      end
    end
    get_local $res
  )
)

(assert_return (invoke "fac-expr" (i64.const 25)) (i64.const 7034535277573963776))
(assert_return (invoke "fac-stack" (i64.const 25)) (i64.const 7034535277573963776))
(assert_return (invoke "fac-mixed" (i64.const 25)) (i64.const 7034535277573963776))

