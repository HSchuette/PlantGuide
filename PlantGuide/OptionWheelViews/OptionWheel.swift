////
////  OptionWheel.swift
////  PlantRoom
////
////  Created by (non work) on 10.10.20.
////
//
//import SwiftUI
//import MessageUI
//
//struct OptionWheel: View {
//    @Binding var isMenuOpen: Bool
//
//    @State private var showMailHandler: Bool = false
//    @State private var showImpressum: Bool = false
//
//    @State private var result: Result<MFMailComposeResult, Error>? = nil
//    @State private var alertNoMail = false
//    
//    let feedback = UIImpactFeedbackGenerator(style: .light)
//
//    var body: some View {
//        ZStack {
//            GearView2()
//                .offset(x: isMenuOpen ? 50 : 0)
//                .onTapGesture {
//                    withAnimation(Animation.easeInOut(duration: 1)) {
//                        self.isMenuOpen.toggle()
//                        self.feedback.impactOccurred()
//                    }
//                }
//
//            ZStack {
//
//
//                Group {
//                    Circle()
//                        .trim(from: 0, to: 0.5)
//                        .fill(Color(.systemGray6))
//                        .rotationEffect(Angle(degrees: isMenuOpen ? 90 : 0))
//                        .onTapGesture {
//                            self.feedback.impactOccurred()
//                            MFMailComposeViewController.canSendMail() ? self.showMailHandler.toggle() : self.alertNoMail.toggle()
//                        }
//                        .sheet(isPresented: $showMailHandler) {
//                            MailHandler(result: self.$result)
//                        }
//                        .alert(isPresented: self.$alertNoMail) {
//                            Alert(title: Text("Error"), message: Text("It seems that you haven't set up an e-mail account on your device yet."))
//                        }
//
//
//                    Image(systemName: "envelope")
//                        .font(.system(size: 20))
//                        .offset(x: -40, y: -40)
//                        .rotationEffect(Angle(degrees: isMenuOpen ? 0 : -90))
//                    }
//                Group {
//                    Circle()
//                        .trim(from: 0, to: 0.5)
//                        .fill(Color(.systemGray5))
//                        .onTapGesture {
//                            withAnimation(.default) {
//                                self.showImpressum = true
//                                self.feedback.impactOccurred()
//                            }
//                        }.alert(isPresented: self.$showImpressum) {
//                            Alert(title: Text("Made with ♥"), message: Text("by Hendrik Schuette, 2020"), dismissButton: .default(Text("Cancel")))
//                        }
//
//                    Image(systemName: "info")
//                        .font(.system(size: 20))
//                        .offset(x: -40, y: 40)
//                }
//
//            }.rotationEffect(Angle(degrees:  isMenuOpen ? 0 : -90))
//            .shadow(color: Color(UIColor.black).opacity(0.1), radius: 4)
//            .frame(width: 200, height: 200)
//
//        }
//    }
//}
//
//struct OptionWheel_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            OptionWheel(isMenuOpen: Binding.constant(true))
//            OptionWheel(isMenuOpen: Binding.constant(false))
//        }
//    }
//}
//
//func GearView2() -> some View {
//    ZStack(alignment: .leading) {
//        Group {
//            Rectangle()
//                .cornerRadius(20)
//                .foregroundColor(Color(.systemGray4))
//                .opacity(0.4)
//
//            HStack {
//                Rectangle()
//                    .cornerRadius(12)
//                    .foregroundColor(Color(.systemBackground))
//                    .frame(width: 30, height: 30)
//            }.padding(.leading, 8)
//
//        }
//        .shadow(color: Color(UIColor.systemGray).opacity(0.1), radius: 4)
//
//        Image(systemName: "gear")
//            .padding(.leading, 13.5)
//
//    }.frame(width: 100, height: 50)
//    .shadow(color: Color(UIColor.black).opacity(0.1), radius: 1)
//}
//
