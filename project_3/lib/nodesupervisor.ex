defmodule NodeSupervisor do
  use DynamicSupervisor

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__,:noargs,name: __MODULE__)
  end

  def init(:noargs) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def add_child() do
    {:ok,pid}=DynamicSupervisor.start_child(__MODULE__, CheckNode)
    pid
  end
end

