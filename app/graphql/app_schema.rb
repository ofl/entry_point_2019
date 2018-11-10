class AppSchema < GraphQL::Schema
  max_complexity 400
  max_depth 10

  rescue_from(Exception) do |error|
    case error
    when ActiveRecord::RecordInvalid
      raise Errors::BadRequest
    when ActiveRecord::RecordNotFound
      raise Errors::NotFound, error.message
    else
      Rails.logger.error error.message
      Rails.logger.error error.backtrace.join("\n")

      GraphQL::ExecutionError.new '原因不明のエラーが発生しました'
    end
  end

  mutation(Types::MutationType)
  query(Types::QueryType)
end
