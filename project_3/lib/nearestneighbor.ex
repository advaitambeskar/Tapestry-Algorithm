defmodule NearestNeighbor do
  def nearestneighbor(node, sorted_map) do
    # given string node and a lookuptable, the idea is to find the closest string?
    # convert the hexadecimal 'node' to integer?
    # sorted_map => sorted integer map -> convert the answer into hexadecimal when returning
    # node => hexadecimal value of string

    node_int = String.to_integer(node, 16);
    # now that we have the integer form of the given hexademical number, we can use it to compare to
    # the lookup table and find the nearest neighbor
    length = Enum.count(sorted_map)
    index = 0
    sorted_map_int = Enum.map(
      sorted_map, fn x -> String.to_integer(x, 16) end
    )
    closestNeighbor = near_finder(node_int, sorted_map_int, length, index)

    closestNeighbor
  end

  def near_finder(node, sorted_map, length, index) do
    if(index >= length) do
      %{}
    else
      currentValue = sorted_map.at(index)
      if(node <= currentValue) do
        # This is where we pass the function to find the closest neighbor
        if(index != 0) do
          currentdifference = abs(node - currentValue)
          previousvalue = sorted_map.at(index - 1)
          previousdifference = abs(node - previousvalue)
          if(currentdifference <= previousdifference) do
            #the current value is closest neighbor. so we return currentvalue in hex
            # this needs to be returned
            closest_neighbor = Integer.to_string(currentValue, 16)
          else
            # this needs to be returned
            closest_neighbor = Integer.to_string(previousvalue, 16)
          end
        else
          # this needs to be returned
          closest_neighbor = Integer.to_string(currentValue, 16)
        end
      else
        index++
        near_finder(node, sorted_map, length, index)
      end
    end
  end
end
