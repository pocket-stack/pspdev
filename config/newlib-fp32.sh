# Nested toolchains source this after their defaults.
if [[ -n "${PSPDEV_FP32_USER_CONFIG_OVERRIDE:-}" ]]; then
  source "${PSPDEV_FP32_USER_CONFIG_OVERRIDE}" || return
fi

if [[ -n "${PSPTOOLCHAIN_ALLEGREX_NEWLIB_CLANG_TARGET_FLAGS+x}" ]]; then
  # -msingle-float alone can select FPXX and emit unsupported SDC1/LDC1.
  PSPTOOLCHAIN_ALLEGREX_NEWLIB_CLANG_TARGET_FLAGS="${PSPTOOLCHAIN_ALLEGREX_NEWLIB_CLANG_TARGET_FLAGS} -mfp32"
fi
