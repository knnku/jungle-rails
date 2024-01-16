describe("Feature Spec: Product Details", () => {
  beforeEach(() => {
    cy.visit("localhost:3000");
  });

  it("User can navigate on a product and open it's details", () => {
    cy.contains("Scented Blade").click()
    cy.url().should("eq", "http://localhost:3000/products/2");
    cy.get("p").should("contain", "found mostly in savannas");
  });
});
