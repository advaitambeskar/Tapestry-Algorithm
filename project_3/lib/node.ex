defmodule CheckNode do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__,:noargs,name: __MODULE__)
  end

  def init(:noargs) do
    {:ok,1}
  end

  def get_state(pid) do
    GenServer.call(pid,:getstate)
  end

  def handle_call(:getstate,_from,state) do
    {:reply,state,state}
  end
end

