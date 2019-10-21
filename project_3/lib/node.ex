defmodule CheckNode do
  use GenServer

  def start(node_id) do
    {:ok,pid} = GenServer.start(__MODULE__,node_id)
    {node_id,pid}
  end

  def get_state(pid) do
    GenServer.call(pid,:getstate)
  end

  def update_state(pid,routing_table) do
    GenServer.cast(pid,{:updateState,routing_table})
  end



  def handle_call(:getstate,_from,state) do
    {:reply,state,state}
  end

  def handle_cast({:updateState,routing_table},state_map) do
    state_map = Map.put(state_map,:routing_table , routing_table)
    {:noreply,state_map}
  end



  def init(node_id) do
    # init_routing_table = create_initial_routing_table(node_id)
    {:ok,%{:nodeID=>node_id}}
  end
end
