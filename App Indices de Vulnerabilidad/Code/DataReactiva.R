# Carga Reactiva 

IPCreact = reactive({
  
  # IPC = IPC_canton[[as.numeric(input$region)]]
  IPC = IPC_canton[[input$region]]
  print("Data IPC Reactiva Cargada  ****************")
  return(IPC)
  
})