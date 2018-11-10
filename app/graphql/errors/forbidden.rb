class Errors::Forbidden < GraphQL::ExecutionError
  def initialize
    super('アクセスできません')
  end

  def to_h
    super.merge('extensions' => { 'code' => 'Errors::Forbidden' })
  end
end
