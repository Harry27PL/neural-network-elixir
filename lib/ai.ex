defmodule Ai do

  def getRandomFloat() do
    random = :crypto.strong_rand_bytes(1) |> :erlang.binary_to_list |> Enum.at(0)
    random = random - 128
    :erlang.round(random / 256 * 10) / 10
  end

  def getRandomFloatList(n) do
    for _ <- 1..n, do: getRandomFloat
  end

end
