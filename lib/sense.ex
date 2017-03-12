
defmodule Sense do
  def input(input, neuron, map) do
    send neuron, {map, input}
  end
end
