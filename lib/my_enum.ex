defmodule MyEnum do

  def each_acc([h|t], callback, acc \\ 0) do
    callback.(h, acc)
    each_acc(t, callback, acc + 1)
  end

  def each_acc([], _callback, _acc) do
    :ok
  end

end
