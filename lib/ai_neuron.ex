defmodule Ai.Neuron do

  def start_link(number_of_data) do

    weights = Ai.getRandomFloatList(number_of_data + 1)

    {:ok, pid} = Agent.start_link(fn -> [
      weights: weights,
      bias: 1
    ] end)

    pid
  end

  ##

  def calculate(pid, data) do

    state   = Agent.get(pid, &(&1))
    weights = state[:weights]
    bias    = state[:bias]

    sum = sum([bias|data], weights)

    :math.tanh(sum)
  end

  defp sum([h1|t1], [h2|t2]) do
    h1 * h2 + sum(t1, t2)
  end

  defp sum([], []) do
    0
  end

end
