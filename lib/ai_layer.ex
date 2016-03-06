defmodule Ai.Layer do

  def start_link(number_of_neurons, number_of_data, is_last, is_hidden) do

    neurons = for _k <- 0..number_of_neurons-1 do
      Ai.Neuron.start_link(number_of_data)
    end

    {:ok, pid} = Agent.start_link(fn -> [
      neurons: neurons,
      is_last: is_last,
      is_hidden: is_hidden
    ] end)

    pid
  end

  ##

  def calculate(pid, data) do

    neurons = Agent.get(pid, &(&1))[:neurons]

    for neuron <- neurons do
      Ai.Neuron.calculate(neuron, data)
    end

  end

end
