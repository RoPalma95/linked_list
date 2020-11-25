# frozen_string_literal: true

class LinkedList
  private

  attr_writer :head, :tail, :size

  public

  attr_reader :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  private

  def create_node(value, index = nil)
    node = Node.new(value, index)
    self.size += 1
    node
  end

  public

  def append(value)
    node = create_node(value)
    node.index = size
    if head.nil?
      self.head = node
      self.tail = head
    else
      tail.next_node = node
      self.tail = node
    end
  end

  def prepend(value)
    node = create_node(value)
    node.index = 1
    node.next_node = head
    self.head = node
    if head.nil?
      self.head = node
      self.tail = head
    end
    adjust_indices('i', head.next_node)
  end

  def insert_at(value, index)
    if index > (size + 1)
      puts "Index has to be #{size + 1} or lower."
    elsif index == (size + 1)
      append(value)
    elsif index == 1
      prepend(value)
    else
      previous_node = at(index - 1)
      new_node = create_node(value, index)
      next_node = at(index)
      previous_node.next_node = new_node
      new_node.next_node = next_node
      adjust_indices('i', next_node)
    end
  end

  def at(index)
    if index > size
      "Index #{index} does not exist."
    else
      current_node = head
      current_node = current_node.next_node until current_node.index == index
      current_node
    end
  end

  def pop
    current_node = head
    (size - 2).times do
      current_node = current_node.next_node
    end
    self.tail = current_node
    tail.next_node = nil
    self.size -= 1
  end

  def remove_at(index)
    if index > size
      puts "Index has to be #{size} or lower."
    elsif index == size
      pop
    elsif index == 1
      self.head = at(2)
      head.index = 1
      adjust_indices('r', head.next_node)
      self.size -= 1
    else
      previous_node = at(index - 1)
      current_node = at(index)
      next_node = current_node.next_node
      previous_node.next_node = next_node
      adjust_indices('r', next_node)
      self.size -= 1
    end
  end

  def contains?(value)
    current_node = head
    current_node = current_node.next_node until current_node.nil? || current_node.value == value
    current_node.nil? ? false : true
  end

  def find(value)
    if contains?(value)
      current_node = head
      current_node = current_node.next_node until current_node.value == value
      current_node.index
    else
      "Value #{value} does not exist."
    end
  end

  def adjust_indices(insert_remove, node = nil)
    if insert_remove == 'i'
      until node.nil?
        node.index += 1
        node = node.next_node
      end
    else
      until node.nil?
        node.index -= 1
        node = node.next_node
      end
    end
  end

  def to_s
    if size.zero?
      'The list is empty.'
    else
      current_node = head
      (size - 1).times do
        print "( #{current_node.value} ) -> "
        current_node = current_node.next_node
      end
      "( #{tail.value} ) -> nil"
    end
  end
end

class Node
  attr_accessor :value, :next_node, :index

  def initialize(value = nil, index = nil)
    @value = value
    @next_node = nil
    @index = index
  end
end

my_list = LinkedList.new

10.times do |i|
  my_list.append(i + 1)
end

puts my_list

my_list.append(11)
puts my_list

my_list.prepend(0)
puts my_list

my_list.insert_at(5.75, 7)
puts my_list
puts my_list.find(10)

my_list.pop
puts my_list

my_list.remove_at(7)
puts my_list

my_list.remove_at(1)
puts my_list

puts my_list.contains?(-1)
puts my_list.contains?(7)

puts my_list.find(10)
