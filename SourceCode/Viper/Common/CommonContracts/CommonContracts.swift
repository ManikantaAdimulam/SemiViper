//
//  CommonContracts.swift
//  Viper
//

/// This protocol can be implemented by the all the router. This avoids sending multiple router objects to achieve the same.
protocol CommonRoutingDelegate: class {

    /// This function can be called to dismiss view presented by respective routers.
    func dismissViewController(ofType type: String)
}
