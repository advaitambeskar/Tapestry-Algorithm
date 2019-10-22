defmodule Routing do
  def beginRouting(currentNetworkMap, number_of_messages_to_send_per_node) do
    # ----------------------------------------------------------------------- #
    # ----- currentNetworkMap is of key-value pair of "node-id" : "pid" ----- #
    # ----------------------------------------------------------------------- #
    random_selected_source = select_random_node(currentNetworkMap, 1);
    random_selected_destinations = {}
    random_selected_destinations = select_random_node(currentNetworkMap, number_of_messages_to_send_per_node, random_selected_source, random_selected_destinations)

    # IO.inspect("Randomly selected source is")
    # IO.inspect random_selected_source
    # IO.inspect(Enum.fetch!(random_selected_source, 1))
    state_of_random_pid = CheckNode.get_state(Enum.fetch!(random_selected_source, 1))

    IO.inspect state_of_random_pid
  end

  def select_random_node(networkMap, number_of_random_selection) do
    Tuple.to_list(Enum.random(networkMap))
  end

  def select_random_node(networkMap, number_of_selections, node_to_skip, destination) do
    if(number_of_selections == 0) do
      destination
    else
      number_of_selections = number_of_selections - 1
      random_node = Enum.random(networkMap)
      if(random_node == node_to_skip || Enum.any?(destination, fn x ->
        x == random_node
      end)) do
        select_random_node(networkMap, number_of_selections, node_to_skip, destination)
      else
        Tuple.append(destination, random_node)
      end

      select_random_node(networkMap, number_of_selections, node_to_skip, destination)
    end
  end
  def routingtable(current_node, level_to_check, destination_node) do
    current_node_state = CheckNode.get_state(current_node)
    current_node
    # at the end of the thing, increase the level to check by 1
    # at the end of the thing, update the current_node to the new_node
  end
end
