//
// Wire
// Copyright (C) 2018 Wire Swiss GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//

import Foundation

extension ConversationInputBarViewController {

    @objc(presentImagePickerWithSourceType:mediaTypes:allowsEditing:pointToView:)
    func presentImagePicker(with sourceType: UIImagePickerController.SourceType,
                            mediaTypes: [String],
                            allowsEditing: Bool,
                            pointToView: UIView?) {

        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController as? PopoverPresenter & UIViewController else { return }

        if !UIImagePickerController.isSourceTypeAvailable(sourceType) {
            if UIDevice.isSimulator {
                let testFilePath = "/var/tmp/video.mp4"
                if FileManager.default.fileExists(atPath: testFilePath) {
                    uploadFile(at: URL(fileURLWithPath: testFilePath))
                }
            }
            return
            // Don't crash on Simulator
        }

        let presentController = {() -> Void in

            let context = ImagePickerPopoverPresentationContext(presentViewController: rootViewController,
                                                                sourceType: sourceType)

            let pickerController = UIImagePickerController.popoverForIPadRegular(with: context)
            pickerController.delegate = self
            pickerController.allowsEditing = allowsEditing
            pickerController.mediaTypes = mediaTypes
            pickerController.videoMaximumDuration = ZMUserSession.shared()!.maxVideoLength()

            if let popover = pickerController.popoverPresentationController,
               let imageView = pointToView {
                popover.config(from: rootViewController,
                               pointToView: imageView,
                               sourceView: rootViewController.view)

                popover.backgroundColor = .white
                popover.permittedArrowDirections = .down
            }

            if sourceType == .camera {
                switch Settings.shared().preferredCamera {
                case .back:
                    pickerController.cameraDevice = .rear
                case .front:
                    pickerController.cameraDevice = .front
                }
            }

            rootViewController.present(pickerController, animated: true)
        }

        if sourceType == .camera {
            execute(videoPermissions: presentController)
        } else {
            presentController()
        }
    }
}