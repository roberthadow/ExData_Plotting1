# Hadow DevDataProd Shiny application
# server.R

test <- c("Mammogram","PSA","HIV")
prev <- c(0.01,.01,.003)
sens <- c(.678,.631, .95)
spec <- c(.75,.349,.95)
test <- data.frame(test, prev, sens, spec)
rm(prev, sens, spec)
#test = read.csv("test.csv", header=TRUE)

A <- array(c(1, 0, 0, 0), c(4,4))  # A, b, and z are setups for linear equations
b <-  c(1, 0, 0, 0)  #
z <-  c(1, 10, -7, 4)  # z is the solution to the linear equations of TP,FN etc

calc <- function(te, tr, pr, se, sp, tn) {
        if (te == "another") test <- tn
        else {    # Assemble a set of linear equations from lookup or user input
                pr <- test[te == test$test, "prev"]
                se <- test[te == test$test, "sens"]
                sp <- test[te == test$test, "spec"]
        }
        A[2,2] <- A[2,4] <- pr
        A[2,1] <- A[2,3] <- pr -1
        A[3,3] <- se
        A[3,1] <- se - 1
        A[4,2] <- sp
        A[4,4] <- sp - 1

        z  <- solve(A,b)  # solve the set of simultaneous linear equations
        pp <- ifelse(tr == "Positive", z[1]/(z[1] + z[2]), z[4]/(z[3] + z[4]))
        W <- NULL; W$pp <-0
        W$A <- A
        W$pp <- pp
        W$test <- test
        W$z <-z
        cm1 <- c("True Positive", "False Negative")
        cm4 <- c("False Positive", "True Negative")
        cm2 <- c(z[1], z[3])
        cm3 <- c(z[2], z[4])
        cm <- data.frame(cm1, cm2, cm3, cm4)
        colnames(cm) <- c(" ", "Disease", " ", " ")
        W$cm <- cm
        W
        }

shinyServer(function(input, output) {

        output$uotr <- reactive({input$uitr})
        reactive({tr <- ifelse(input$uitr == "Positive", "Positive", "Negative")})
        output$uote <- reactive({ifelse(input$uite == "another", input$uitn, input$uite)})
        output$uopr <- reactive({ifelse(input$uite == "another", input$uipr,
                test[input$uite == test$test, "prev"])})
        output$uose <- reactive({ifelse(input$uite == "another", input$uise,
                test[input$uite == test$test, "sens"])})
        output$uosp <- reactive({ifelse(input$uite == "another", input$uisp,
                test[input$uite == test$test, "spec"])})
        output$uopp <- reactive({calc(input$uite, input$uitr, input$uipr,
                input$uise, input$uisp, input$uitn)$pp})
        output$uocm <- renderPrint({calc(input$uite, input$uitr, input$uipr,
                                         input$uise, input$uisp, input$uitn)$cm})
})


