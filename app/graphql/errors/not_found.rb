class Errors::NotFound < GraphQL::ExecutionError
  def initialize(message)
    super(message)
  end

  def to_h
    super.merge('extensions' => { 'code' => 'Errors::NotFound' })
  end
end
