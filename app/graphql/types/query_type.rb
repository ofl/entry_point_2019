module Types
  class QueryType < Types::BaseObject
    description 'The query root of this schema'

    field :articles,     resolver: Queries::Articles::Index
    field :pagedArticles, resolver: Queries::Articles::PagedIndex
    field :searchArticles, resolver: Queries::Articles::Search
    field :article,      resolver: Queries::Articles::Show
    field :current_user, resolver: Queries::Users::CurrentUser
    field :user,         resolver: Queries::Users::Show
    field :followings,   resolver: Queries::Users::Followings
    field :followers,    resolver: Queries::Users::Followers
  end
end
