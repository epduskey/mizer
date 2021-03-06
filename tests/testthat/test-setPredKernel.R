params <- NS_params
no_sp <- nrow(params@species_params)

## setPredKernel ----
test_that("setPredKernel works", {
    expect_equal(setPredKernel(params), params)
    expect_equal(setPredKernel(params, pred_kernel = NULL), 
                     params)
    params@species_params$pred_kernel_type <- "box"
    params@species_params$ppmr_min <- 2
    expect_error(setPredKernel(params), 
                 "missing from the parameter dataframe: ppmr_max")
    params@species_params$ppmr_max <- 4
    p2 <- setPredKernel(params)
    pred_kernel <- getPredKernel(params)
    expect_error(setPredKernel(params, pred_kernel[1:2, ]),
                 "incorrect number of dimensions")
    expect_error(setPredKernel(params, pred_kernel - 1),
                 "pred_kernel >= 0 are not true")
    p2 <- setPredKernel(params, pred_kernel)
    expect_equal(p2@ft_pred_kernel_e, array())
    expect_equal(p2@ft_pred_kernel_p, array())
    expect_equivalent(p2@pred_kernel, pred_kernel)
    expect_identical(p2@pred_kernel, getPredKernel(p2))
})
test_that("Comment works on pred kernel", {
    pred_kernel <- getPredKernel(params)
    comment(pred_kernel) <- "test"
    params_c <- setPredKernel(params, pred_kernel = pred_kernel)
    expect_identical(comment(params_c@pred_kernel), "test")
})

test_that("setPredKernel sets comments correctly", {
    pred_kernel <- getPredKernel(params)
    # The comment argument is ignored when the values is already commented
    comment(pred_kernel) <- "test"
    params <- setPredKernel(params, pred_kernel = pred_kernel,
                            comment_pred_kernel = "overwrite")
    expect_identical(comment(params@pred_kernel), "test")
    # But otherwise the comment arguments are stored correctly.
    comment(pred_kernel) <- NULL
    params <- setPredKernel(params, pred_kernel = pred_kernel,
                            comment_pred_kernel = "overwrite")
    expect_identical(comment(params@pred_kernel), "overwrite")
})

# getPredKernel ----
test_that("getPredKernel has correct dimnames",{
    pred_kernel <- getPredKernel(params)
    expect_identical(dimnames(pred_kernel)$sp, 
                     dimnames(params@initial_n)$sp)
    expect_identical(dimnames(pred_kernel)$w_pred, 
                     dimnames(params@initial_n)$w)
    expect_identical(dimnames(pred_kernel)$w_prey, 
                     as.character(signif(params@w_full, 3)))
})
test_that("getting and setting pred kernel leads to same dynamics" ,{
    params <- NS_params
    params <- setPredKernel(params, pred_kernel = getPredKernel(params))
    sim1 <- project(NS_params, t_max = 0.1)
    sim2 <- project(params, t_max = 0.1)
    expect_equal(finalN(sim1), finalN(sim2), tolerance = 1e-4)
})


## get_phi ----
test_that("get_phi works", {
    NS_species_params$pred_kernel_type <- "box"
    NS_species_params$ppmr_min <- 2
    NS_species_params$ppmr_max <- 4
    phi <- get_phi(NS_species_params, 1:5)
    expect_identical(phi[1, ], phi[2, ])
    expect_identical(phi[1, 1], 0)
    expect_identical(phi[1, 2], 1)
    expect_identical(phi[1, 5], 0)
})