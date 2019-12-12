def knapsack(profits, weights, bag)
  tabulations  = []
  previous_tabulation = tabulations[0] = [0] * bag + 1
  weights.each_index do |index|
    weight = weights[index]
    profit = profits[index]
    tabulation = [0]
    if weight > bag
      next
    else
      tabulation[0...weight] = previous_tabulation[0...weight]
      tabulation[weight] = profits[index] > previous_tabulation[weight] ? tabulation[weight] : previous_tabulation[weight]

    end
    tabulations << tabulation
    previous_tabulation =  tabulation
  end
end
