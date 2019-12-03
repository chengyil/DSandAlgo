# https://leetcode.com/problems/task-scheduler/
# @param {Character[]} tasks
# @param {Integer} n
# @return {Integer}
def least_interval(tasks, n)
   calculate_by_math(tasks,n)
end

def calculate_by_math(tasks, n)
    # M = elements with the most frequency, would indicate the number of block - 1
    # A##,A##
    # part(M) = count(M) - 1
    # empty_slots =  part(M) * (n - count(M) * F - 1)
    # remaining_tasks = tasks.length - count(M) * F
    # idles = max(0, empty_slots - remaining_tasks)
    # schedule = tasks.length + idle
    max_count = 0
    max_items = []
    tasks.reduce({}) do |sum, task|
        sum[task] = (sum[task]||0) + 1
        if max_count < sum[task]
            max_count = sum[task]
            max_items = [task]
        elsif max_count == sum[task]
            max_items << task
        end
        sum
    end
    partition  = max_count - 1
    empty_slots = partition * (n - (max_items.count - 1))
    remaining_tasks = tasks.count - max_count * max_items.count
    idles = [0, empty_slots - remaining_tasks].max
    schedule = tasks.count + idles
end

def calculate_by_map(tasks,n)
    keys = (1...26).reduce(['A']) {|s,c| s[c] = s[c-1].succ; s}.each.with_index.reduce({}) {|s,(v,i)| s[v] = i; s}
    map = tasks.reduce([]) do |map, task|
        map[keys[task]] = (map[keys[task]] || 0) + 1
        map
    end
    map.sort!
    schedule = 0
    until(map[-1].zero?)
        (0..n).each do |index|
            if map[-1].zero?
                break
            elsif index < 26 && map[-index-1]
                map[-index-1] -=1
            end
            schedule+=1
        end
        map.sort!
    end
    schedule
end

def main
  p least_interval(["A","A","A","B","B","B"], 2) == 8
end
main
