workspace "ZEISS KINEVO 900 S Context" "Context, Container, Component, and Deployment diagrams for the neurosurgical microscope system" {
  model {
    neurosurgeon = person "Neurosurgeon" {
      description "Uses the microscope during neurosurgical procedures"
    }

    assistant = person "Surgical Assistant" {
      description "Supports the surgeon and interacts with the microscope's external monitor"
    }

    admin = person "Hospital IT Admin" {
      description "Manages integration with hospital systems and data security"
    }

    microscope = softwareSystem "ZEISS KINEVO 900 S Microscope" {
      description "Robotic visualization system for neurosurgery with 4K 3D imaging, cobotics, and connected intelligence"
      

      // Hardware Containers
      mainUnit = container "Main Microscope Unit" "Robotic arm, optics, sensors" "Hardware" {
        // No components for mainUnit
      }
      controlConsole = container "Control Console" "Touchscreen interface, voice assistant" "Hardware" {
        userInteraction = component "User Interaction Layer" "Touch UI, voice assistant, preset configurations" "C++/Qt"
      }
      externalMonitor = container "External Monitor" "4K 3D display for exoscopic viewing" "Hardware" {
        // No components for externalMonitor
      }
      wearableDisplay = container "Wearable Display (HMDmd CR3)" "Optional head-mounted display" "Hardware" {
        // No components for wearableDisplay
      }

      // Software Containers
      embeddedRTOS = container "Embedded Real-Time OS" "Robotic control and image processing" "Software" {
        roboticControl = component "Robotic Control System" "Manages motorized movements, PointLock, PositionMemory, AutoCenter" "C++"
      }
      visualizationEngine = container "Visualization Engine" "4K 3D rendering, DepthPro mode" "Software" {
        visualizationPipeline = component "Visualization Pipeline" "4K 3D camera input, real-time rendering, fluorescence imaging" "C++"
      }
      aiModule = container "AI Module" "AutoCenter, voice commands, smart positioning" "Software" {
        // No components for aiModule
      }
      connectivityLayer = container "Connectivity Layer" "Interfaces with cloud, PACS, data platforms" "Software" {
        dataManagement = component "Data Management & Integration" "Secure data transfer, live streaming, integration with planning tools" "C++"
        cybersecurity = component "Cybersecurity & Compliance" "Encrypted communication, regulatory compliance" "C++"
      }
    }

    cloud = softwareSystem "ZEISS Surgical Cloud" {
      description "Cloud platform for data storage, streaming, and analytics"
    }

    pacs = softwareSystem "Hospital PACS System" {
      description "Stores and retrieves medical imaging data"
    }

    emr = softwareSystem "Hospital EMR System" {
      description "Electronic medical records system for patient data"
    }

    nav = softwareSystem "Navigation System (e.g., BrainLAB)" {
      description "Provides surgical navigation and trajectory mapping"
    }

    azure = softwareSystem "Microsoft Azure Health Data Services" {
      description "Cloud infrastructure for secure health data management"
    }

    // Context relationships
    neurosurgeon -> microscope "Operates during surgery"
    assistant -> microscope "Observes and assists via external monitor"
    admin -> microscope "Manages system integration and updates"

    microscope -> cloud "Streams and stores surgical data"
    microscope -> pacs "Sends imaging data"
    microscope -> emr "Retrieves patient context"
    microscope -> nav "Receives trajectory data"
    cloud -> azure "Hosted on"

    // Container relationships (internal to microscope)
    neurosurgeon -> controlConsole "Operates via touchscreen and voice"
    neurosurgeon -> wearableDisplay "Views through wearable display"
    assistant -> externalMonitor "Observes via external monitor"
    mainUnit -> embeddedRTOS "Robotic control and image processing"
    embeddedRTOS -> visualizationEngine "Sends image data"
    visualizationEngine -> aiModule "Uses AI for smart features"
    aiModule -> connectivityLayer "Sends data for integration"
    connectivityLayer -> cloud "Uploads surgical data"
    connectivityLayer -> pacs "Sends imaging data"
    connectivityLayer -> emr "Retrieves patient context"
    connectivityLayer -> nav "Receives navigation data"

    // Component relationships (within containers, no dot notation)
    roboticControl -> visualizationPipeline "Sends processed data"
    userInteraction -> aiModule "Sends user commands"
    dataManagement -> cloud "Uploads data"
    dataManagement -> pacs "Sends imaging data"
    dataManagement -> emr "Retrieves patient context"
    dataManagement -> nav "Receives navigation data"
    cybersecurity -> cloud "Secures data transfer"

    // Deployment environment
    hospital = deploymentEnvironment "Hospital" {
      deploymentNode "Operating Room" {
        deploymentNode "ZEISS KINEVO 900 S Microscope" {
          containerInstance mainUnit
          containerInstance controlConsole
          containerInstance externalMonitor
          containerInstance wearableDisplay
          containerInstance embeddedRTOS
          containerInstance visualizationEngine
          containerInstance aiModule
          containerInstance connectivityLayer
        }
      }
      
      deploymentNode "Hospital Network" {
        softwareSystemInstance pacs
        softwareSystemInstance emr
        softwareSystemInstance nav
      }
      
      deploymentNode "Cloud" {
        softwareSystemInstance cloud
        softwareSystemInstance azure
      }
    }
  }

  views {
    systemContext microscope {
      include *
      autolayout lr
      title "ZEISS KINEVO 900 S - System Context"
      description "Context diagram for the neurosurgical microscope system"
    }

    container microscope {
      include *
      autolayout lr
      title "ZEISS KINEVO 900 S - Container Diagram"
      description "Container diagram showing hardware and software modules"
    }

    component embeddedRTOS {
      include roboticControl
      autolayout lr
      title "Embedded RTOS - Component Diagram"
      description "Component diagram for the Embedded Real-Time OS"
    }

    component visualizationEngine {
      include visualizationPipeline
      autolayout lr
      title "Visualization Engine - Component Diagram"
      description "Component diagram for the Visualization Engine"
    }

    component controlConsole {
      include userInteraction
      autolayout lr
      title "Control Console - Component Diagram"
      description "Component diagram for the Control Console"
    }

    component connectivityLayer {
      include dataManagement
      include cybersecurity
      autolayout lr
      title "Connectivity Layer - Component Diagram"
      description "Component diagram for the Connectivity Layer"
    }

    deployment microscope hospital {
      include *
      autolayout lr
      title "ZEISS KINEVO 900 S - Deployment Diagram"
      description "Deployment diagram showing physical deployment in hospital environment"
    }

    styles {
      element "Person" {
        shape "person"
        background "#f2f2f2"
        color "#000000"
      }

      element "Software System" {
        shape "roundedbox"
        background "#1168bd"
        color "#ffffff"
      }

      element "Container" {
        shape "hexagon"
        background "#6fa8dc"
        color "#ffffff"
      }

      element "Component" {
        shape "component"
        background "#ffe599"
        color "#000000"
      }

      element "Deployment Node" {
        shape "folder"
        background "#b4a7d6"
        color "#000000"
      }

      relationship "Relationship"{
        thickness 2
        color "#707070"
      }
    }
  }
}
