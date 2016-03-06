defmodule Ai.NeuralNetwork do

  def start_link(number_of_data, number_of_neurons) do

    number_of_layers = Enum.count(number_of_neurons)

    layers = for k <- 0..number_of_layers-1 do

      number_of_neuron_data = if k == 0 do
        number_of_data
      else
        Enum.at(number_of_neurons, k - 1)
      end

      is_last = k == number_of_layers - 1
      is_hidden = !is_last && k > 0

      Ai.Layer.start_link(Enum.at(number_of_neurons, k), number_of_neuron_data, is_last, is_hidden)

    end

    {:ok, pid} = Agent.start_link(fn -> [
      layers: layers
    ] end)

    pid
  end

  ##

  def calculate(pid, data) do

    layers = Agent.get(pid, &(&1))[:layers]

    Enum.reduce(layers, data, fn(layer, data) ->
      Ai.Layer.calculate(layer, data)
    end)

  end

  ##

  def print(pid) do

    layers = Agent.get(pid, &(&1))[:layers]

    MyEnum.each_acc(layers, fn(layer, i) ->
      IO.puts "----warstwa #{i}"

      neurons = Agent.get(layer, &(&1))[:neurons]

      MyEnum.each_acc(neurons, fn(neuron, i) ->
        IO.puts "--neuron #{i}"

        state   = Agent.get(neuron, &(&1))
        weights = state[:weights]
        bias    = state[:bias]

        IO.puts "bias #{1}"
        IO.puts "wagi:"
        IO.inspect weights

      end)
    end)

  end

end
