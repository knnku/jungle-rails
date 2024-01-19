describe("Feature Spec: Add to cart", () => {
  beforeEach(() => {
    cy.visit("localhost:3000");
  });

  it("User can add an item to the cart", () => {
    // Set to force:true as cypress keeps scrolling the page up, covering the btn with navbar
    cy.get('form[action="/cart/add_item?product_id=2"] button').click({ force: true });

    //Check if cart has number 1
    cy.get('a[href="/cart"]').invoke('text').should('include', '1');
  });
});
