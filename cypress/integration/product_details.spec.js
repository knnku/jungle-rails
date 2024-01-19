describe("Feature Spec: Product Details", () => {
  beforeEach(() => {
    cy.visit("localhost:3000");
  });

  it("User can navigate on a product and open it's details", () => {
    cy.get('a[href*="products/2"]').click();

    //two assertions to be sure!
    cy.url().should("eq", "http://localhost:3000/products/2");
    cy.get("p").should("contain", "found mostly in savannas");
  });
});
