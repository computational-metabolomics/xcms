## Tests for the lcmsPlot backend on xcmsRaw plot methods.

test_that("xcmsRaw plot methods support backend = 'lcmsPlot'", {
    skip_if_not_installed("lcmsPlot")
    skip_on_os(os = "windows", arch = "i386")

    xraw <- xcmsRaw(faahko_3_files[1], profstep = 1)

    res <- plotTIC(xraw, backend = "lcmsPlot")
    expect_true(inherits(res, c("ggplot", "patchwork")))

    res <- plotEIC(xraw, mzrange = c(334.9, 335.1),
                   rtrange = c(2700, 2900), backend = "lcmsPlot")
    expect_true(inherits(res, c("ggplot", "patchwork")))

    res <- plotChrom(xraw, base = TRUE, backend = "lcmsPlot")
    expect_true(inherits(res, c("ggplot", "patchwork")))

    ## base = FALSE maps onto aggregation_fun = "mean" rather than erroring.
    res <- plotChrom(xraw, base = FALSE, backend = "lcmsPlot")
    expect_true(inherits(res, c("ggplot", "patchwork")))

    res <- plotScan(xraw, scan = 100, backend = "lcmsPlot")
    expect_true(inherits(res, c("ggplot", "patchwork")))

    res <- plotRaw(xraw, mzrange = c(300, 350),
                   rtrange = c(2700, 2900), backend = "lcmsPlot")
    expect_true(inherits(res, c("ggplot", "patchwork")))

    res <- levelplot(xraw, backend = "lcmsPlot")
    expect_true(inherits(res, c("ggplot", "patchwork")))
})

test_that("plotChrom lcmsPlot backend distinguishes BPC from averaged IC", {
    skip_if_not_installed("lcmsPlot")
    skip_on_os(os = "windows", arch = "i386")
    xraw <- xcmsRaw(faahko_3_files[1], profstep = 1)
    bpc <- plotChrom(xraw, base = TRUE, backend = "lcmsPlot")
    aic <- plotChrom(xraw, base = FALSE, backend = "lcmsPlot")
    ## The averaged ion chromatogram is the profile matrix column mean, so it
    ## has to sit below the column maxima of the base peak chromatogram.
    bpc_y <- bpc$data$intensity
    aic_y <- aic$data$intensity
    expect_equal(length(bpc_y), length(aic_y))
    expect_true(all(aic_y <= bpc_y))
    expect_true(any(aic_y < bpc_y))
    ## and it has to match what the base backend computes.
    expect_equal(aic_y, unname(colMeans(xraw@env$profile)), tolerance = 1e-6)
})

test_that("plotSpec has no lcmsPlot backend", {
    skip_on_os(os = "windows", arch = "i386")
    ## lcmsPlot has no cross-scan spectrum averaging, so 'backend' is not a
    ## formal argument here; it would be swallowed by '...' and passed to
    ## profRange() if it ever were.
    expect_false("backend" %in% names(formals(getMethod("plotSpec", "xcmsRaw"))))
    xraw <- xcmsRaw(faahko_3_files[1], profstep = 1)
    expect_error(plotSpec(xraw, backend = "lcmsPlot"))
})
