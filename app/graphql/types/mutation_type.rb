module Types
  class MutationType < Types::BaseObject
    field :create_comment, mutation: Mutations::Comments::Create
    field :update_comment, mutation: Mutations::Comments::Update
    field :destroy_comment, mutation: Mutations::Comments::Destroy
    field :article_toggle_like, mutation: Mutations::Articles::ToggleLike
  end
end
