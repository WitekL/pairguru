class TitleBracketsValidator < ActiveModel::Validator
  BRACKETS = { '[' => ']', '{' =>  '}', '(' => ')' }.freeze

  def validate(record)
    previous_symbol = ''
    stack = []

    record.title.each_char do |char|
      return add_errors(record) if BRACKETS[previous_symbol] == char

      previous_symbol = char

      stack << char if BRACKETS.key?(char)
      return add_errors(record) if BRACKETS.key(char) && BRACKETS.key(char) != stack.pop
    end

    add_errors(record) unless stack.empty?
  end

  private

  def add_errors(record)
    record.errors[:title] << 'is invalid'
  end
end
