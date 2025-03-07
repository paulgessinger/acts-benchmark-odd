

function fatras_reco_chain() {
   # Runnig Fatras
   echo "-- Fatras ... " 
   echo "--events=${N_EVENTS} --dd4hep-input=${ODD_DIR}/xml/OpenDataDetector.xml" > ${OUT_DIR}/fatras.response
   echo "${FATRAS_CONFIG} ${BFIELD_CONFIG} ${MATERIAL_CONFIG}" >> ${OUT_DIR}/fatras.response
   echo "--input-dir=${OUT_DIR}   --output-dir=${OUT_DIR} --output-csv" >> ${OUT_DIR}/fatras.response
   ${INSTALL_DIR}/bin/ActsExampleFatrasDD4hep --response-file=${OUT_DIR}/fatras.response > ${OUT_DIR}/fatras.log
   # Runnint Truth Fitting
   echo "-- Truth Fitting with smeared digitization ... " 
   echo "--events=${N_EVENTS} --dd4hep-input=${ODD_DIR}/xml/OpenDataDetector.xml" > ${OUT_DIR}/fitting.response
   echo "${TRUTH_FITTING_CONFIG}  ${BFIELD_CONFIG} ${MATERIAL_CONFIG} ${DIGI_CONFIG}" >> ${OUT_DIR}/fitting.response
   echo "--input-dir=${OUT_DIR} --output-dir=${OUT_DIR}" >> ${OUT_DIR}/fitting.response
   ${INSTALL_DIR}/bin/ActsExampleTruthTracksDD4hep  --response-file=${OUT_DIR}/fitting.response > ${OUT_DIR}/fitting.log
   # Running the CKF - truth smeared seeds
   echo "-- CKF with smeared digitization, truth smeared seeds ... " 
   echo "--events=${N_EVENTS} --dd4hep-input=${ODD_DIR}/xml/OpenDataDetector.xml" > ${OUT_DIR}/ckf-smeared-seeds.response
   echo "--ckf-truth-smeared-seeds on ${TRUTH_FITTING_CONFIG} ${BFIELD_CONFIG} ${MATERIAL_CONFIG} ${DIGI_CONFIG}" >> ${OUT_DIR}/ckf-smeared-seeds.response
   echo "--input-dir=${OUT_DIR} --output-dir=${OUT_DIR}" >> ${OUT_DIR}/ckf-smeared-seeds.response
   ${INSTALL_DIR}/bin/ActsExampleCKFTracksDD4hep  --response-file=${OUT_DIR}/ckf-smeared-seeds.response > ${OUT_DIR}/ckf-smeared-seeds.log
   mv ${OUT_DIR}/performance_ckf.root ${OUT_DIR}/performance_ckf-smeared-seeds.root
   mv ${OUT_DIR}/trackparams_ckf.root ${OUT_DIR}/trackparams_ckf-smeared-seeds.root
   mv ${OUT_DIR}/trackstates_ckf.root ${OUT_DIR}/trackstates_ckf-smeared-seeds.root
   # Running the CKF - truth estimated seeds
   echo "-- CKF smeared digitization, truth estimated seeds ... " 
   echo "--events=${N_EVENTS} --dd4hep-input=${ODD_DIR}/xml/OpenDataDetector.xml" > ${OUT_DIR}/ckf-estimated-seeds.response
   echo "${CKF_CONFIG} ${BFIELD_CONFIG}" >> ${OUT_DIR}/ckf-estimated-seeds.response
   echo "--ckf-truth-estimated-seeds on ${SEEDING_CONFIG} ${MATERIAL_CONFIG} ${DIGI_CONFIG}" >> ${OUT_DIR}/ckf-estimated-seeds.response
   echo "--input-dir=${OUT_DIR} --output-dir=${OUT_DIR}" >> ${OUT_DIR}/ckf-estimated-seeds.response
   ${INSTALL_DIR}/bin/ActsExampleCKFTracksDD4hep  --response-file=${OUT_DIR}/ckf-estimated-seeds.response > ${OUT_DIR}/ckf-estimated-seeds.log
   mv ${OUT_DIR}/performance_ckf.root ${OUT_DIR}/performance_ckf-estimated-seeds.root
   mv ${OUT_DIR}/trackparams_ckf.root ${OUT_DIR}/trackparams_ckf-estimated-seeds.root
   mv ${OUT_DIR}/trackstates_ckf.root ${OUT_DIR}/trackstates_ckf-estimated-seeds.root
   # Running the CKF - reco seeds
   echo "-- CKF with smeared digitization, reconstructed seeds ... " 
   echo "--events=${N_EVENTS} --dd4hep-input=${ODD_DIR}/xml/OpenDataDetector.xml" > ${OUT_DIR}/ckf-reconstruced-seeds.response
   echo "${CKF_CONFIG} ${BFIELD_CONFIG}" >> ${OUT_DIR}/ckf-reconstruced-seeds.response
   echo "${SEEDING_CONFIG} ${MATERIAL_CONFIG} ${DIGI_CONFIG}" >> ${OUT_DIR}/ckf-reconstruced-seeds.response
   echo "--input-dir=${OUT_DIR} --output-dir=${OUT_DIR}" >> ${OUT_DIR}/ckf-reconstruced-seeds.response
   ${INSTALL_DIR}/bin/ActsExampleCKFTracksDD4hep  --response-file=${OUT_DIR}/ckf-reconstruced-seeds.response > ${OUT_DIR}/ckf-reconstruced-seeds.log
   mv ${OUT_DIR}/performance_ckf.root ${OUT_DIR}/performance_ckf-reconstruced-seeds.root
   mv ${OUT_DIR}/trackparams_ckf.root ${OUT_DIR}/trackparams_ckf-reconstruced-seeds.root
   mv ${OUT_DIR}/trackstates_ckf.root ${OUT_DIR}/trackstates_ckf-reconstruced-seeds.root
}
