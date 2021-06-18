//
//  HmPermissions.swift
//  SwiftUtil
//
//  Created by mfhj-dz-001-059 on 2021/5/8.
//

import UIKit
import Foundation
import Photos

// MARK: - 相册及相机权限
class HmPermissions {
    // 相机权限
    func isRightCamera(complete:@escaping () -> Void) {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .restricted, .denied:
            dPrint("权限已拒绝")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (success) in
                DispatchQueue.main.async(execute: {
                    if success {
                        complete()
                    } else {
                        dPrint("权限已拒绝")
                    }
                })
            }
        case .authorized:
            complete()
        default:
            break
        }
    }
    
    // 相册权限
    func isAuthorizedPhoto(complete:@escaping () -> Void) {
        let photoAuthorStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorStatus {
        case .denied, .restricted:
            dPrint("权限已拒绝")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                DispatchQueue.main.async(execute: {
                    if status == .authorized {
                        complete()
                    } else {
                        dPrint("权限已拒绝")
                    }
                })
            }
        case .authorized:
            complete()
        default:
            break
        }
    }
}
