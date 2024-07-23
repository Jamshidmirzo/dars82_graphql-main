const String getProducts = """
query {
  products(limit: 4, offset: 0, title: "Wholeness") {
    id
    title
    price
    description
  }
}
""";

const String getProductById = """
query {
  product(id: "3279") {
    id
    title
    price
    description
    images
  }
}
""";

const String addProduct = """
mutation createProduct(
    \$title: String!, 
    \$price: Float!, 
    \$description: String!,
    \$categoryId: Float!,
    \$images: [String!]!
) {
    addProduct(
      data: {
        title: \$title
        price: \$price
        description: \$description
        categoryId: \$categoryId
        images: \$images
      }
    ) {
      id
      title
      price
    }
}
""";

const String editProduct = """
mutation editProduct(
    \$id: ID!, 
    \$title: String!, 
    \$price: Float!, 
    \$description: String!,
) {
    updateProduct(
      id: \$id
      changes: {
        title: \$title
        price: \$price
        description: \$description
      }
    ) {
      id
      title
      price
    }
}
""";

const String deleteProduct = """
mutation deleteProduct(
    \$id: ID!
) {
    deleteProduct(
      id: \$id
    )
}
""";
