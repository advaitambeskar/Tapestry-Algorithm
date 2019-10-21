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

  def update_backpointer(pid,node_id) do
    GenServer.cast(pid,{:updateBackpointer,node_id})
  end

  def remove_backpointer(pid,node_id) do
    GenServer.cast(pid,{:removeBackpointer,node_id})
  end

  def handle_call(:getstate,_from,state) do
    {:reply,state,state}
  end

  def handle_cast({:updateState,routing_table},state_map) do
    state_map = Map.put(state_map,:routing_table , routing_table)
    {:noreply,state_map}
  end

  def handle_cast({:removeBackpointer,node_id},state_map) do
    updated_backpointers = List.delete(state_map[:backpointers],node_id)
    state_map = Map.put(state_map,:backpointers,updated_backpointers)
    {:noreply,state_map}
  end

  def handle_cast({:updateBackpointer,node_id},state_map) do
    updated_backpointers= [node_id |state_map[:backpointers]]
    state_map = Map.put(state_map,:backpointers,updated_backpointers)
    {:noreply,state_map}
  end



  def init(node_id) do
    {:ok,%{:nodeID=>node_id,:backpointers=>[]}}
  end
end
