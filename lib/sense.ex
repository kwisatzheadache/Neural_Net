#This isn't doing anything productive yet. The idea is to automate the signal process.
#Need to generate a keymap for the neuron/iex_process/actuator pid's so they can 
#be fed to each component so they can all send/receive.
defmodule Sense do
  @moduledoc """
  typically called by the cortex via:
  send cortex, {:sense}
  or
  send cortex, {:feedback}

  The Cortex.start_link command generates metadata
  containing pids and input.
  """
  def input(neuron, metadata) do
    send neuron,  {:ok, metadata}
  end
end
