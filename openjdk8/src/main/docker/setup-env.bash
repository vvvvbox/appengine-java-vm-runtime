#!/bin/bash
ALPN_BOOT=
if [[ -n "$ALPN_ENABLE" ]]; then
  ALPN_BOOT="$( /opt/alpn/format-env-appengine-vm.sh )"
fi

DBG_AGENT=
if [[ "$GAE_PARTITION" = "dev" ]]; then
  if [[ -n "$DBG_ENABLE" ]]; then
    echo "Running locally and DBG_ENABLE is set, enabling standard Java debugger agent"
    DBG_PORT=${DBG_PORT:-5005}
    DBG_AGENT="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=${DBG_PORT}"
  fi
else
  DBG_AGENT="$( RUNTIME_DIR=$JETTY_BASE /opt/cdbg/format-env-appengine-vm.sh )"
fi

SET_TMP=
if [[ -n "${TMPDIR}" ]]; then
  SET_TMP="-Djava.io.tmpdir=$TMPDIR"
fi

