class Errors::Unauthorized < GraphQL::ExecutionError
  def initialize
    super('ログインが必要です')
  end

  def to_h
    super.merge('extensions' => { 'code' => 'Errors::Unauthorized' })
  end
end
