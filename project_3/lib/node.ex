defmodule CheckNode do
  use GenServer

  def start(hash) do
    {:ok,pid} = GenServer.start(__MODULE__,hash)
    {hash,pid}
  end

  def get_state(pid) do
    GenServer.call(pid,:getstate)
  end



  def handle_call(:getstate,_from,state) do
    {:reply,state,state}
  end

  def init(hash) do
    {:ok,%{:nodeID=>hash}}
  end
end

