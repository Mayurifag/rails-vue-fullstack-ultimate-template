describe("Authentication pages", () => {
  it('loads / page', () => {
    cy.visit('/')
    cy.contains('Login')
  });

  it('loads /forgot_password page', () => {
    cy.visit('/forgot_password')
    cy.contains('Reset password')
  })

  it('loads /signup page', () => {
    cy.visit('/signup')
    cy.contains('Sign up')
  })
});
