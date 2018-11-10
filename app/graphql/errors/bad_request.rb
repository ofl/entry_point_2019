class Errors::BadRequest < GraphQL::ExecutionError
  def initialize
    super('リクエストが正しくありません')
  end

  def to_h
    super.merge('extensions' => { 'code' => 'Errors::BadRequest' })
  end
end
