module Types
  class MutationType < Types::BaseObject
    field :create_article, mutation: Mutations::Articles::Create
    field :update_article, mutation: Mutations::Articles::Update
    field :destroy_article, mutation: Mutations::Articles::Destroy
    field :article_toggle_favorite, mutation: Mutations::Articles::ToggleFavorite

    field :create_comment, mutation: Mutations::Comments::Create
    field :update_comment, mutation: Mutations::Comments::Update
    field :destroy_comment, mutation: Mutations::Comments::Destroy

    field :create_account, mutation: Mutations::Account::Create
    field :update_profile, mutation: Mutations::Profile::Update

    field :user_toggle_follow, mutation: Mutations::Users::ToggleFollow
  end
end
