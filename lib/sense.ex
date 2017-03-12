#This isn't doing anything productive yet. The idea is to automate the signal process.
#Need to generate a keymap for the neuron/iex_process/actuator pid's so they can 
#be fed to each component so they can all send/receive.
defmodule Sense do
  def input(input, neuron, map) do
    send neuron, {map, input}
  end
end
