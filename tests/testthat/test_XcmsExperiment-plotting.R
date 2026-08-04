library(MsExperiment)
fls <- normalizePath(faahko_3_files)
df <- data.frame(mzML_file = basename(fls),
                 dataOrigin = fls,
                 sample = c("ko15", "ko16", "ko18"))
mse <- readMsExperiment(spectraFiles = fls, sampleData = df)

mse_ms2 <- readMsExperiment(pest_mix_dda_file)
p <- CentWaveParam(noise = 10000, snthresh = 40, prefilter = c(3, 10000))
xmse <- findChromPeaks(mse, param = p)
pdp <- PeakDensityParam(sampleGroups = rep(1, 3))
xmseg <- groupChromPeaks(xmse, param = pdp, add = FALSE)
xmsegr <- adjustRtime(xmseg, param = PeakGroupsParam(span = 0.4))

test_that(".plot_adjusted_rtime works, .plot_peak_groups works", {
    .plot_adjusted_rtime(rtime(xmsegr, adjusted = FALSE), rtime(xmsegr),
                         from_file = fromFile(xmsegr))
    ph <- processHistory(xmsegr, type = xcms:::.PROCSTEP.RTIME.CORRECTION)[[1L]]

    rt <- split(rtime(xmsegr, adjusted = FALSE), fromFile(xmsegr))
    rtadj <- split(rtime(xmsegr), fromFile(xmsegr))
    .plot_peak_groups(rt, rtadj, peakGroupsMatrix(ph@param))

    ## simulating a subset:
    idx <- c(1, 3)
    .plot_peak_groups(rt[idx], rtadj[idx],
                      peakGroupsMatrix(ph@param)[, idx, drop = FALSE],
                      col = "red")
})

test_that("plotAdjustedRtime,XcmsExperiment works", {
    expect_warning(plotAdjustedRtime(xmseg), "results present")
    expect_error(plotAdjustedRtime(mse), "XcmsExperiment")
    plotAdjustedRtime(xmsegr, col = "red")
    plotAdjustedRtime(xmsegr, adjustedRtime = FALSE)
})

test_that("plotAdjustedRtime,XcmsExperiment lcmsPlot backend works", {
    skip_if_not_installed("lcmsPlot")
    res <- plotAdjustedRtime(xmsegr, backend = "lcmsPlot")
    expect_true(inherits(res, c("ggplot", "patchwork")))
})

test_that("plotChromPeaks,XcmsExperiment works", {
    expect_true(plotChromPeaks(xmse, 2))
})

test_that("plotChromPeaks,XcmsExperiment lcmsPlot backend works", {
    skip_if_not_installed("lcmsPlot")
    res <- plotChromPeaks(xmse, file = 1, backend = "lcmsPlot")
    expect_true(inherits(res, c("ggplot", "patchwork")))
})

test_that("plotChromPeakImage,XcmsExperiment works", {
    expect_true(plotChromPeakImage(xmse))
})

test_that("plotChromPeakImage,XcmsExperiment lcmsPlot backend works", {
    skip_if_not_installed("lcmsPlot")
    res <- plotChromPeakImage(xmse, backend = "lcmsPlot")
    expect_true(inherits(res, c("ggplot", "patchwork")))
    res_log <- plotChromPeakImage(xmse, binSize = 60, log = TRUE,
                                  backend = "lcmsPlot")
    expect_true(inherits(res_log, c("ggplot", "patchwork")))
    ## The peak counts have to agree with the binning of the base method.
    xl <- c(floor(min(rtime(xmse))), ceiling(max(rtime(xmse))))
    brks <- seq(xl[1], xl[2], by = 30)
    if (brks[length(brks)] < xl[2])
        brks <- c(brks, brks[length(brks)] + 30)
    pks <- chromPeaks(xmse, rt = xl, msLevel = 1L)
    n_base <- sum(hist(pks[pks[, "sample"] == 1, "rt"], breaks = brks,
                       plot = FALSE)$counts)
    n_lcms <- sum(res$data$n_peaks[res$data$metadata_index == 1])
    expect_equal(n_lcms, n_base)
})

test_that("plot,XcmsExperiment and .xmse_plot_xic works", {
    tmp <- filterRt(mse, c(3000, 3100))
    plot(tmp, cex = 0.1)
    plot(tmp, msLevel = 2L)
    tmp <- filterRt(xmse, c(3000, 3100))
    .xmse_plot_xic(tmp, lwd = 3, col = NA, cex = 0.2)

    tmp <- filterMz(filterRt(xmse, rt = c(2550, 2800)), mz = c(342.5, 344.5))
    plot(tmp)
})

test_that("plot,XcmsExperiment lcmsPlot backend works", {
    skip_if_not_installed("lcmsPlot")
    tmp <- filterMz(filterRt(mse, rt = c(2550, 2800)), mz = c(342.5, 344.5))
    res <- plot(tmp, backend = "lcmsPlot")
    expect_true(inherits(res, c("ggplot", "patchwork")))
})

test_that("plotPrecursorIons works", {
    expect_error(plotPrecursorIons(3), "MsExperiment")
    a <- readMsExperiment(pest_mix_swath_file)
    plotPrecursorIons(a, main = "SWATH")

    plotPrecursorIons(a, main = c("a", "b"))
    plotPrecursorIons(a)
    a <- readMsExperiment(pest_mix_dda_file)
    plotPrecursorIons(a)
})

test_that(".xmse_plot_xic works with ms2 data", {
  tmp <-  filterMz(filterRt(mse_ms2, rt= c(210, 220)), mz = c(500, 510))
  plot(tmp)
})
